console.log("room.js execute");
App.room = App.cable.subscriptions.create({ channel: "RoomChannel", room: "" }, {
  connected: function () {
    // Called when the subscription is ready for use on the server
  },

  disconnected: function () {
    // Called when the subscription has been terminated by the server
  },

  received: function (data) {
    alert(data['message']);
    // Called when there's incoming data on the websocket for this channel
  },

  speak: function (message) {
    return this.perform('speak', { message: message });
  }
})