{% extends "../layouts/default.swig" %}

{% macro showPost(post) %}
  <div class="post" data-ks-editable="editable(user, { list: 'Post', id: post.id })">
    <div class="post-preview">
      {% if post.image.exists %}
        <img src="{{ post._.image.fit(400,300) }}"
	  class="img text-center" width="100%" height="260px">
      {% endif %}
      <a href="/blog/post/{{ post.slug }}">
        <h2 class="post-title">
	  {{ post.title }}
	</h2>
	<h3 class="post-subtitle">
	  {{ post.content.brief | safe }}
	</h3>
      </a>
      <p class="post-meta">Posted by
	<a href="#">
	  {% if post.author %} {{ post.author.name.first }}
	  {% endif %}
	</a>
	{% if post.publishedDate %}
	  on {{ post._.publishedDate.format("MMMM Do, YYYY") }}
	{% endif %}	
	{% if post.categories and post.categories.length %}
	  in
	  {% for cat in post.categories %}
	    <a href="/blog/{{ cat.key }}">{{ cat.name }}</a>
	    {% if loop.index < post.categories.length - 1 %},
	    {% endif %}
	  {% endfor %}
	{% endif %}
      </p>
      {% if post.content.extended %}
	<a class="read-more" href="/blog/post/{{ post.slug }}">
	  Read more...
	</a>
      {% endif %}
    </div>
    <hr>
  </div>
{% endmacro %}

{% block intro %}
  <div class="container">
    {% set title = "Blog" %}
    {% if data.category %}
      {% set title = data.category.name %}
    {% endif %}
    <h1>{{ title }}</h1>
  </div>
{% endblock %}

{% block content %}
  <div class="container">
    <div class="row">
      <div class="col-sm-8 col-md-9">
	{% if filters.category and not data.category %}
	  <h3 class="text-muted">Invalid Category.</h3>
	{% else %}
	  {% if data.posts.results.length %}
	    {% if data.posts.totalPages > 1 %}
	      <h4 class="text-weight-normal">Showing 
		<strong>{{ data.posts.first }}</strong>
		to 
		<strong>{{ data.posts.last }}</strong>
		of 
		<strong>{{ data.posts.total }}</strong>
		posts.
	      </h4>
	    {% else %}
	      <h4 class="text-weight-normal">Showing
		{{ utils.plural(data.posts.results.length, "* post") }}.</h4>
	    {% endif %}
	    <div class="blog">
	      {% for post in data.posts.results %}
		{{ showPost(post) }}
	      {% endfor %}
	    </div>
	    {% if data.posts.totalPages > 1 %}
	      <ul class="pagination">
		{% if data.posts.previous %}
		  <li>
		    <a href="?page={{ data.posts.previous }}">
		      <span class="glyphicon glyphicon-chevron-left"></span>
		    </a>
		  </li>
		{% else %}
		  <li class="disabled">
		    <a href="?page=1">
		      <span class="glyphicon glyphicon-chevron-left"></span>
		    </a>
		  </li>
                {% endif %}
		{% for p in data.posts.pages %}
		  <li class="{% if data.posts.currentPage == p %}active{% endif %}">
		    <a href="?page={% if p == "..." %}{% if i %}{{ data.posts.totalPages }}{% else %}1{% endif %}{% else %}{{ p }}{% endif %}">{{ p }}</a>
		  </li>
		{% endfor %}
		{% if data.posts.next %}
		  <li>
		    <a href="?page={{ data.posts.next }}">
		      <span class="glyphicon glyphicon-chevron-right"></span>
		    </a>
		  </li>
		{% else %}
		  <li class="disabled">
		    <a href="?page={{ data.posts.totalPages }}">
		      <span class="glyphicon glyphicon-chevron-right"></span>
		    </a>
		  </li>
		{% endif %}
	      </ul>
	    {% endif %}
	  {% else %}
	    {% if data.category %}
	      <h3 class="text-muted">There are no posts in the category {{ data.category.name }}.</h3>
	    {% else %}
	      <h3 class="text-muted">There are no posts yet.</h3>
	    {% endif %}
	  {% endif %}
	{% endif %}
      </div>
      {% if data.categories.length %}
	<div class="col-sm-4 col-md-3">
	  <h2>Categories</h2>
	  <div class="list-group" style="margin-top: 70px;">
	    <a href="/blog" class="{% if not data.category %}active{% endif %} list-group-item">All Categories</a>
	    {% for cat in data.categories %}
	      <a href="/blog/{{ cat.key }}" class="{% if data.category and data.category.id == cat.id %}active{% endif %} list-group-item">{{ cat.name }}</a>
	    {% endfor %}
	  </div>
	</div>
      {% endif %}
    </div>
  </div>
{% endblock %}
