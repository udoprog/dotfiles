def merge(target, key, value):
    """
    Merge scoped dictionaries.
     * Dicts can be merged with other dicts, where the first key has priority.
     * Lists are merged.
    """
    if isinstance(value, dict):
        try:
            t = target[key]
        except KeyError:
            target[key] = value
            return

        if not isinstance(t, dict):
            raise Exception('target: not a dict')

        for (k, v) in value.items():
            merge(t, k, v)

        return

    if isinstance(value, list):
        try:
            t = target[key]
        except KeyError:
            target[key] = value
            return

        if not isinstance(t, list):
            raise Exception('target: not a list')

        t.extend(value)
        return

    if key not in target:
        target[key] = value
