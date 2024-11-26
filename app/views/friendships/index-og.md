<h1>Friends</h1>

<h2>Your Friends</h2>
<% if @friends.any? %>
  <ul>
    <% @friends.each do |friend| %>
      <li><%= friend.email %></li>
    <% end %>
  </ul>
<% else %>
  <p>You have no friends yet.</p>
<% end %>

<h2>All Users</h2>
<% if @all_users.any? %>
  <ul>
    <% @all_users.each do |user| %>
      <li>
        <%= user.email %>
        <%= button_to "Add Friend", friendships_path(friend_id: user.id), method: :post %>
      </li>
    <% end %>
  </ul>
<% else %>
  <p>No other users available.</p>
<% end %>
