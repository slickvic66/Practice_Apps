var makeTagController = function (element) {
  var tagController = {
    addTag: function (data) {
      facebox = $('<div></div>')
        .addClass('facebox')
        .css('left', data.x)
        .css('top', data.y)
        .append(
          $('<div></div>')
            .addClass('name')
            .text(data.name)
       );
      element.append(facebox);
      this.listenHover(facebox);
    },

    showFaceBox: function (data){
      element.append(
        $('<div></div>')
          .addClass('facebox temp')
          .css('left', data.x)
          .css('top', data.y)
      );
    },

    deleteTemp: function () {
      $('.temp').detach();
    },

    showTextBox: function (pos) {
      element.append(
        $('.temp')
          .css('left', pos.x)
          .css('top', pos.y)
          .append(
            $('<input type="text"></input>')
          )
      );

      $('input').focus();
    },

    showNames: function (names) {
      $('.facebox.temp').append($('<div></div>').addClass('name-list'));
      for (var n = 0; n < names.length; n++ ){
        $('.name-list').append(
          $('<a href="#"></a>').append(
              $('<div></div>')
              .attr('id', names[n])
              .text(names[n])
          )
        );
      }
    },

    tagHandler: function (e) {
      if (e.which == 13) {
        this.data.name = $('input').val();
        this.deleteTemp();
        if (this.data.name.replace(/^\s+$/, '') !== '') {
          tagData.add(this.data);
          this.addTag(this.data);
        }
      }
    },

    listHandler: function (e) {
      e.stopPropagation();
      this.data.name = $(e.target).attr('id');
      this.deleteTemp();
      tagData.add(this.data);
      this.addTag(this.data);
    },

    clickHandler: function (e) {
      this.deleteTemp();

      this.data = {
        x: parseInt(e.pageX, 0) - 50 + "px",
        y: parseInt(e.pageY, 0) - 50 + "px",
        name: null
      };

      this.showFaceBox(this.data);
      this.showTextBox(this.data);
      this.showNames(tagData.names());
      $('.name-list').click(this.listHandler.bind(this));
      $('input').keypress(this.tagHandler.bind(this));
    },

    listen: function () {
      element.click(this.clickHandler.bind(this));
    },

    listenHover: function (element) {
      $(element).hover(this.showCloseBtn.bind(this), this.hideCloseBtn.bind(this));
    },

    showCloseBtn: function(e){
      facebox = ($(e.target).is('.facebox')) ? $(e.target) : $(e.target).parent();
      console.log(facebox);
      facebox.append($('<a href = "#"></a>').addClass('closebtn-a')
        .append(
        $('<div></div>')
          .addClass("closebtn")
          .text('x')
        )
      );

      this.listenCloseClick();
    },

    listenCloseClick: function(){
      $('.closebtn a').click(this.closeHandler.bind(this));
    },

    closeHandler: function(e){
      console.log('in handler');
      e.stopPropagation();
      // figure out what tag it is
      console.log(e.target.parent());
      // remove the tag from the DOM (.facebox)
      // find name on tag
      // remove name from tagData
    },

    hideCloseBtn: function(e){
      $('.closebtn').remove();
    }
  };

  tagController.listen();

  return tagController;
};


var makeButtonController = function (element) {
  var buttonController = {
    hidden: false,
    showTags: function () {
      $('.facebox').css('display', 'block');
      $('button').text('Hide Tags');
    },

    hideTags: function () {
      $('.facebox').css('display', 'none');
      $('button').text('Show Tags');
    },

    clickHandler: function (e) {
      if (this.hidden) {
        this.showTags();
        this.hidden = false;
      } else {
        this.hideTags();
        this.hidden = true;
      }
    },

    listen: function () {
      element.click(this.clickHandler.bind(this));
    }
  };

  buttonController.listen();

  return buttonController;
};

var tagData = {
  data: [
    {
      x: '100px',
      y: '300px',
      name: 'John'
    }
  ],

  add: function (data) {
    this.data.push(data);
  },

  remove: function (name) {
    index = null;
    for (var i = 0; i < this.data.length; i++) {
      if (data[i].name == name) {
        index = i;
      }
    }

    this.data.splice(index, 1);
  },

  names: function () {
    names = [];
    for (var i = 0; i < this.data.length; i++) {
      names.push(this.data[i].name);
    }
    return names;
  }
};

var displayTags = function (data) {
  for (var tag in data) {
    tagController.addTag(data[tag]);
  }
};


var Photo = function (id, url) {
  this.id = null;
  this.url = url;
  this.save = function () {
    $.post(
      '/photos.json',
      {photo: {
        id: this.id,
        url: this.url
      }},
      function (response) {
        console.log(response);
      }
    );
  };
  this.render = function (element) {
    $(element).css('background-image', 'url(' + this.url + ')');
  };
};

Photo.all = [];
Photo.fetchAll = function (callback) {
  $.getJSON(
    '/photos.json',
    function (photos) {
      Photo.all = [];
      _.each(photos, function (photo) {
        Photo.all.push(new Photo(photo['id'], photo['url']));
      });

      if (callback) {
        callback($('body'), Photo.all);
      }
    }
  );
};

var listPhotos = function (element, photos) {
  $(element).append('<ul></ul>').addClass('photo-list');
  _.each(photos, function (photo) {
    $('ul.photo-list')
  });
};

$(function () {
  photo = new Photo(null, 'http://betanews.com/wp-content/uploads/2012/12/Bye-e1325189368276.jpg');
  photo.render($('.canvas'));
  Photo.fetchAll(listPhotos);
  tagController = makeTagController($('.canvas'));
  makeButtonController($('button'));
});