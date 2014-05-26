module.exports.init = function(app){

	app.get('/', _index);

	function _index(req, res) {
		res.render('index', {});
	}
};