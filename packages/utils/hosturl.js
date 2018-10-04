// Licensed to the Apache Software Foundation (ASF) under one or more contributor
// license agreements; and to You under the Apache License, Version 2.0.

/**
 * @param path the action name as just <action name> or <pkgname>/<action name>.
 * @param web if true return path for web action, otherwise path to invoke via POST with API key.
 * @param ext extension one of [".json", ".text", ".html", ".http"] or default (".json").
 * @param trigger if true, construct path for trigger instead of action.
 * @return URL for action.
 */
function main(args) {
    let host = process.env.__OW_API_HOST;
    let ns = process.env.__OW_NAMESPACE;
    let web = `${host}/api/v1/web/${ns}`;
    let collection = args.trigger === true ? 'triggers' : 'actions';
    let post = `${host}/api/v1/namespaces/${ns}/${collection}`;
    let base = args.web === true ? web : post;

    if (args.web === true && args.trigger) {
        return { error: 'triggers are not allowed for web actions.' };
    } else if (args.web === true && args.ext) {
        if (args.ext !== '.html' && args.ext !== '.http' && args.ext !== '.json' && args.ext !== '.svg' && args.ext !== '.text') {
            return { error: 'extension for web action must be one of [".html", ".http", ".json", ".svg", ".text"].' };
        }
    } else if (args.trigger && args.path.indexOf('/') !== -1) {
        return { error: 'triggers are not allowed in packages.' };
    }

    if (args.path) {
        let path = args.web === true && args.path.indexOf('/') === -1 ? `default/${args.path}` : args.path;
        let ext = args.web === true ? (args.ext || '') : '';
        return { url: `${base}/${path}${ext}` };
    } else {
        return { url: base };
    }
}
