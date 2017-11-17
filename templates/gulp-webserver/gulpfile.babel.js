// ------------------------
// gulpfile.babel.js
// ------------------------

import gulp from 'gulp'
import webserver from 'gulp-webserver'

gulp.task('default',() => {
	return gulp.src('./')
	.pipe(webserver({
		liveload: true,
		directoryListing: true,
		host: '0.0.0.0', // Docker上で動かすので
		port: 3000
	}));
});


