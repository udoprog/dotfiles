import os
from pystache.renderer import Renderer
import yaml

from .utils import merge

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
    def __init__(self, renderer, root, scoped):
        self._renderer = renderer
        self._root = root
        self._scoped = scoped

    def _items(self):
        return [{
            'key': k,
            'value': Lookup(self._renderer, self._root, v),
        } for (k, v) in self._scoped.items()]

    def _render(self, template):
        return self._renderer.render(template, self)

    def _keys(self, name):
        value = self

        for p in name.split('.'):
            value = value.__getattr__(p)

        if not isinstance(value._scoped, dict):
            raise Exception('not a dict')

        return value._scoped.keys()

    def __getattr__(self, name):
        if name == 'items()':
            return self._items()

        if name == '':
            value = self._root
        else:
            value = self._scoped[name]

        if isinstance(value, list):
            return [Lookup(self._renderer, self._root, v) for v in value]

        return Lookup(self._renderer, self._root, value)

    def __str__(self):
        return str(self._scoped)

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
        else:
            raise Exception(config + ": missing hierarchy")

        root = dict(os.environ)

        for h in hierarchy:
            if not os.path.isfile(h):
                continue

            for (k, v) in yaml.load(open(h)).items():
                merge(root, k, v)

        # apply scopes
        scoped = apply_scopes(root, ns.scopes)

        # manual overrides with `--set <key>=<value>`
        for (key, value) in ns.values:
            scoped[key] = value

        return Lookup(renderer, root, scoped)
