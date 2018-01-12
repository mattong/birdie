require('./app.scss')

function requireAll (r) { r.keys().forEach(r) }
requireAll(require.context('./components/', true, /\.s?css$/))
requireAll(require.context('./pages/', true, /\.s?css$/))
