import os
import yaml
import json

from .utils import merge

from pystache.renderer import Renderer

def apply_scopes(db, scopes):
    if len(scopes) == 0:
        return db

    result = dict()

    for scope in scopes:
        current = db

        for p in scope.split('.'):
            p = p.strip()

            if len(p) <= 0:
                continue

            try:
                current = current[p]
            except KeyError:
                raise Exception('bad scope: {}'.format(scope))

        result.update(current)

    return result

class Lookup(object):
    def __init__(self, hierarchy, renderer, root, scoped):
        self._hierarchy = hierarchy
        self._renderer = renderer
        self._root = root
        self._val = scoped

    def _lookup(self, value):
        return Lookup(self._hierarchy, self._renderer, self._root, value)

    def _items(self):
        return [{'key': k, 'value': self._lookup(v)} for (k, v) in self._val.items()]

    def _render(self, template):
        return self._renderer.render(template, self)

    def _keys(self, name):
        value = self.__getitem__(name)

        if not isinstance(value._val, dict):
            raise Exception('not a dict')

        return value._val.keys()

    def __iter__(self):
        if isinstance(self._val, list):
            raise Exception('not a list')

        return (self._lookup(v) for v in self._val)

    def __getitem__(self, name):
        value = self

        for p in name.split('.'):
            p = p.strip()

            if len(p) == 0:
                continue

            value = value.__getattr__(p)

        return value

    def __getattr__(self, name):
        if name == 'items()':
            return self._items()

        if name == '':
            value = self._root
        else:
            value = self._val[name]

        if isinstance(value, list):
            return [self._lookup(v) for v in value]

        return self._lookup(value)

    def __str__(self):
        if isinstance(self._val, list):
            return json.dumps(self._val)

        if isinstance(self._val, dict):
            return json.dumps(self._val)

        return str(self._val)

    @staticmethod
    def setup_parser(parser):
        parser.add_argument(
            '--scope',
            dest='scopes',
            action='append',
            default=[])

        parser.add_argument(
            '--set',
            metavar='<key>=<value>',
            dest='values',
            type=lambda v: v.split('=', 2),
            action='append', default=[])

    @staticmethod
    def load(ns):
        renderer = Renderer(missing_tags='strict')

        config = os.path.join(ns.root, 'config.yml')
        facts = os.path.join(ns.root, 'facts.yml')

        c = yaml.load(open(config))
        f = yaml.load(open(facts))
        f['distro'] = os.getenv('DISTRO')

        hierarchy = c.get('hierarchy')

        if hierarchy is not None and isinstance(hierarchy, list):
            hierarchy = [os.path.join(ns.root, h.format(**f)) for h in hierarchy]
            hierarchy = list(filter(os.path.isfile, hierarchy))
        else:
            raise Exception(config + ": missing hierarchy")

        root = dict(os.environ)

        for h in hierarchy:
            for (k, v) in yaml.load(open(h)).items():
                merge(root, k, v)

        # apply scopes
        scoped = apply_scopes(root, ns.scopes)

        # manual overrides with `--set <key>=<value>`
        for (key, value) in ns.values:
            scoped[key] = value

        return Lookup(hierarchy, renderer, root, scoped)
