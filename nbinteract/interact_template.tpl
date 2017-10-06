{% extends "full.tpl" %}

<!--
Overwrite the widget output blocks since they were using jQuery uselessly.
-->
{%- block data_widget_state scoped %}
{% set div_id = uuid4() %}
{% set datatype_list = output.data | filter_data_type %}
{% set datatype = datatype_list[0]%}
<div id="{{ div_id }}"></div>
<div class="output_subarea output_widget_state {{ extra_class }}">
<script type="{{ datatype }}">
{{ output.data[datatype] | json_dumps }}
</script>
</div>
{%- endblock data_widget_state -%}

{%- block data_widget_view scoped %}
{% set div_id = uuid4() %}
{% set datatype_list = output.data | filter_data_type %}
{% set datatype = datatype_list[0]%}
<div id="{{ div_id }}"></div>
<div class="output_subarea output_widget_view {{ extra_class }}">
<script type="{{ datatype }}">
{{ output.data[datatype] | json_dumps }}
</script>
</div>
{%- endblock data_widget_view -%}
<!--
Overwrite head tag in HTML. This is directly copied from nbinteract's
full.tpl file and thus will have to updated when the full.tpl file changes.

Unfortunately, the template doesn't provide a way of changing only the lines
we need to change so we're overwriting the whole thing.
-->
{%- block html_head -%}
<meta charset="utf-8" />
<title>{{resources['metadata']['name']}}</title>

<!-- This line contains the JS to run the widget code -->
<script src="https://unpkg.com/nbinteract@*/js/built/index.built.js"></script>

{% for css in resources.inlining.css -%}
    <style type="text/css">
    {{ css }}
    </style>
{% endfor %}

<style type="text/css">
/* Overrides of notebook CSS for static HTML export */
body {
  overflow: visible;
  padding: 8px;
}

div#notebook {
  overflow: visible;
  border-top: none;
}

{%- if resources.global_content_filter.no_prompt-%}
div#notebook-container{
  padding: 6ex 12ex 8ex 12ex;
}
{%- endif -%}

@media print {
  div.cell {
    display: block;
    page-break-inside: avoid;
  }
  div.output_wrapper {
    display: block;
    page-break-inside: avoid;
  }
  div.output {
    display: block;
    page-break-inside: avoid;
  }
}
</style>

<!-- Custom stylesheet, it must be in the same directory as the html file -->
<link rel="stylesheet" href="custom.css">

<!-- Loading mathjax macro -->
{{ mathjax() }}
{%- endblock html_head -%}