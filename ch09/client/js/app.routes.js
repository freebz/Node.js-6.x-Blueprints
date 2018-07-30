(function(){
    'use strict';

    angular
	.module('bikesGallery')
	.config(routes);

    routes.$inject = ['$stateProvider'];

    function routes($stateProvider) {
	$stateProvider
	    .state('home', {
		url: '/',
		templateUrl: 'views/home.html',
		controller: 'HomeController',
		controllerAs: 'vm'
	    })
	    .state('galleries', {
		url: '/galleries/{itmeId}/bikes',
		templateUrl: 'views/galleries.html',
		controller: 'GalleryController',
		controllerAs: 'vm'
	    });
    }
})();
