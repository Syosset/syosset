function Support() {}
Support.prototype = {
  log: function(msg) {
    console.log("[Support] " + msg);
  },

  fetchThread: function(callback) {
    $.ajax('/threads/create', {context: this, headers: {'X-CSRF-Token': Rails.csrfToken()}})
      .done(function(response) {
        this.log("Thread retrieved: " + response);
        callback(response);
      }).fail(function() {
        this.log("Failed to retrieve thread!");
        callback(null);
      });
  },

  openThread: function(callback) {
    this.fetchThread(function(id) {
      var thread = new Thread(id, this.log);
      setInterval(thread.update.bind(thread), 1500); // update every 1.5s
      thread.update(function() {
        callback(thread);
      });
    }.bind(this));
  }
}

function Thread(id, logger) {
  this.id = id;
  this.logger = logger;
  this.messages = [];
  this.onMessageCallback = function(msg){this.log(msg.sender.name + ": " + msg.message)};
}
Thread.prototype = {
  log: function(msg) {
    this.logger('[' + this.id + '] ' + msg);
  },

  fetchMessages: function(callback) {
    $.ajax(this.id + '/messages', {context: this, headers: {'X-CSRF-Token': Rails.csrfToken()}})
      .done(function(messages) {
        this.log(messages.length + " messages retrieved");
        callback(messages);
      }).fail(function() {
        this.log("Failed to retrieve messages!");
        callback(null);
      });
  },

  fetchNewMessages: function(callback) {
    this.fetchMessages(function(messages) {
      var newMessages = messages.filter(function(msg){return !this.messages.includes(msg.id)}.bind(this));
      this.messages += newMessages.map(function(msg){return msg.id});
      callback(newMessages);
    }.bind(this));
  },

  sendMessage: function(text) {
    $.ajax(this.id + '/messages', {method: "POST", data: {text: text}, context: this, headers: {'X-CSRF-Token': Rails.csrfToken()}})
      .done(function(message) {
        this.messages += message.id;
        this.onMessage(message);
      });
  },

  update: function(callback) {
    this.fetchNewMessages(function(messages) {
      if (typeof callback == 'function') callback();
      messages.forEach(function(msg){this.onMessage(msg)}.bind(this));
    }.bind(this));
  },

  onMessage: function(arg) {
    if (typeof arg == 'function') {
      this.onMessageCallback = arg;
    } else {
      this.onMessageCallback(arg);
    }
  }
}

window.Support = new Support();
