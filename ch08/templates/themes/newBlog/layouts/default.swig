{% import "../mixins/flash-messages.swig" as FlashMessages %}

<!doctype html>
<html>
	<head>		
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">

		<title>{{ title|default("ch08") }}</title>
		<link rel="shortcut icon" href="/favicon.ico" type="image/x-icon">

		{# 커스텀 폰트 #}
		<link href="http://maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
		<link href='http://fonts.googleapis.com/css?family=Lora:400,700,400italic,700italic' rel='stylesheet' type='text/css'>
		<link href='http://fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,800italic,400,300,600,700,800' rel='stylesheet' type='text/css'>

		{# 사이트 스타일 시트를 커스터마이즈하려면 /public/styles/site.sass를 수정 #}
		<link href="/styles/site.css" rel="stylesheet">

		<!-- 팬시박스 -->
		<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/fancybox/2.1.5/jquery.fancybox.min.css" media="screen">
		
		{# 이 파일은 KeystoneJS 콘텐츠 편집기에 대한 기본 스타일을 제공한다. #}
		{%- if user and user.canAccessKeystone -%}
			<link href="/keystone/styles/content/editor.min.css" rel="stylesheet">
		{%- endif -%}

		{# HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries
		   Safely remove this block if you are not targeting IE8 #}
		<!--[if lt IE 9]>
			<script src="//cdn.jsdelivr.net/html5shiv/3.7.3/html5shiv.js"></script>
			<script src="//cdn.jsdelivr.net/respond/1.4.2/respond.min.js"></script>
		<![endif]-->

		{# Include template-specific stylesheets by extending the css block #}
		{%- block css %}{% endblock -%}

		{# Add any other template-specific HEAD tags by extending the head block #}
		{%- block head %}{% endblock %}
	</head>
	<body>

		{# HEADER #}
		<div id="header">

		  {# 사이트 내비게이션을 커스터마이즈하려면
		    ./routes/middleware.js 파일에 있는 navLinks 배열을 수정하거나
		    디자인에 맞춰 이 header를 완전히 바꾸면 된다. #}

		  <!-- 내비게이션 -->
		  <nav class="navbar navbar-default navbar-custom navbar-fixed-top">
		    <div class="container-fluid">
		      <!-- 모바일에서 더 나은 화면을 위해 브랜드와 토글을 그룹화 -->
		      <div class="navbar-header page-scroll">
		        <button type="button" class="navbar-toggle" data-toggle="collapse"
			  data-target="#bs-example-navbar-collapse-1">
			  <span class="sr-only">Toggle navigation</span>
			  <span class="icon-bar"></span>
			  <span class="icon-bar"></span>
			  <span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="/">newBlog</a>
		      </div>
		      <!-- 토글링을 위해 내비게이션 링크, 폼, 기타 콘텐츠 모아놓기 -->
		      <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
		        <ul class="nav navbar-nav navbar-left">
		          {%- for link in navLinks -%}
			    {%- set linkClass = '' -%}
			    {%- if link.key == section -%}
			      {%- set linkClass = ' class="active"' -%}
			    {%- endif %}
			  <li{{ linkClass | safe }}>
			  <a href="{{ link.href }}">{{ link.label }}</a>
			  </li>
			  {%- endfor %}
		        </ul>
		        <ul class="nav navbar-nav navbar-right">
		          {% if user -%}
			    {%- if user.canAccessKeystone -%}
			      <li><a href="/keystone">Open Keystone</a></li>
			    {%- endif -%}
			    <li><a href="/keystone/signout">Sign Out</a></li>
			  {%- else -%}
			    <li><a href="/keystone/signin">Sign In</a></li>
			  {%- endif %}
		        </ul>
		      </div>
		      <!-- /.navbar-collapse -->
		    </div>
		    <!-- /.container-fluid -->
		  </nav>
		  <!-- 페이지 헤더 -->
		  <header class="intro-header">
		    <div class="container">
		      <div class="row">
		        <div class="col-lg-8 col-lg-offset-2 col-md-10 col-md-offset-1">
		          <div class="site-heading">
			    <h1>Node.js 6 Blueprints Book</h1>
			    <hr class="small">
			    <span class="subheading">A Clean Blog using KeystoneJS</span>
			  </div>
		        </div>
		      </div>
		    </div>
		  </header>
	        </div>
		
	        {# BODY #}
	        <div id="body">
	          {# body 블록 주변에는 디자인의 유연성을 위해 .container 래핑 클래스가 없다.
		    인트로/콘텐츠 블록을 오버라이드하려면 템플릿에 이를 포함하는 걸 잊지 말자. #}

		  {# 플래시 메시지 위로 표시되는 인트로 블록(임시 정보 표시용). #}
		  {%- block intro -%}{%- endblock -%}

		  {# 폼 유효성 에러/성공 등 일회성 상태 표시에 사용되는 플래시 메시지 #}
		  {{ FlashMessages.renderMessages(messages) }}

		  {# 콘텐츠 블록은 템플릿 콘텐츠의 body를 포함해야 한다. #}
		  {%- block content -%}{%- endblock -%}
	        </div>

		{# JAVASCRIPT #}

		{# jQuery 1.11.3 is included by default, and required by both Bootstrap
			and the KeystoneJS Content Editor. If you are not targeting IE8,
			you can upgrade to 2.1.4 (also bundled) for better performance. #}
		<script src="/js/jquery/jquery-1.11.3.min.js"></script>

		{# Customise which Bootstrap javascript files are served by including
			them specifically here, instead of bootstrap-3.3.5.min.js #}
		<script src="/js/bootstrap/bootstrap-3.3.5.min.js"></script>

		{# The KeystoneJS Content Editor provides support for ks-editable data attributes,
			which generate links to edit content for users who can access Keystone #}
		{% if user and user.canAccessKeystone -%}
			<script src="/keystone/js/content/editor.js"></script>
		{%- endif -%}

		{# 사이트에 전역적으로 필요한 스크립트는 이곳에 추가 #}

		<script src="https://cdnjs.cloudflare.com/ajax/libs/fancybox/2.1.5/jquery.fancybox.min.js"></script>
		<script>
		  $(document).ready(function(){
		    // Gallery
		    $(".fancybox").fancybox({
		      openEffect: "elastic",
		      closeEffect: "elastic"
		    });
		    // 컨택트 폼을 위한 플로팅 레이블
		    $("body").on("input propertychange", ".floating-label-form-group", function(e) {
		      $(this).toggleClass("floating-label-form-group-with-value", !!(e.target).val());
		    }).on("focus", ".floating-label-form-group", function() {
		      $(this).addClass("floating-label-form-group-with-focus");
		    }).on("blur", ".floating-label-form-group", function() {
		      $(this).removeClass("floating-label-form-group-with-focus");
		    });
		  });
		</script>

		{# js 블록을 확장하여 템플릿 자바스크립트 파일을 포함 #}
		{%- block js -%}{%- endblock -%}
	</body>
</html>
