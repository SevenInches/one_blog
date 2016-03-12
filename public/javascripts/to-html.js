(function() {
  var d = document, s = d.createElement('script');

  s.src = '//oneblogpadrino.disqus.com/embed.js';

  s.setAttribute('data-timestamp', +new Date());
  (d.head || d.body).appendChild(s);
})();

$(function(){
  Editor($("#blog_body"), $("#blog_body"));

    function Editor(input, preview) {
      //console.log(markdown.toHTML(input.text()));
      this.update = function () {
        var html = markdown.toHTML(input.text());
        preview.html(html);
      };
        input.editor = this;
      this.update();
    }
})




