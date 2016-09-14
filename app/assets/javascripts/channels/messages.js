App.messages = App.cable.subscriptions.create("MessagesChannel", {
  connected: function() {
    // Called when the subscription is ready for use on the server
  },
  disconnected: function() {
    // Called when the subscription has been terminated by the server
  },
  received: function(data) {
    if(window.location.pathname === '/' || gon.user_id === data.sender.id){
      network.addMessage(data);
    }
  }
});
