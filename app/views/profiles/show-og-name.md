<h1><%= @user.name %>'s Profile</h1>
<p><strong>Bio:</strong> <%= @profile.bio.presence || "No bio provided" %></p>
<p><strong>Avatar:</strong></p>
<% if @profile.avatar_url.present? %>
  <img src="<%= @profile.avatar_url %>" alt="<%= @user.name %>'s Avatar">
<% else %>
  <p>No avatar set.</p>
<% end %>

<%= link_to "Edit Profile", edit_user_profile_path(@user), class: "btn btn-primary" %>


<h1>STARTER</h1>
<p style="color: green"><%= notice %></p>

<%= render @profile %>

<div>
  <%= link_to "Edit this profile", edit_profile_path(@profile) %> |
  <%= link_to "Back to profiles", profiles_path %>

  <%= button_to "Destroy this profile", @profile, method: :delete %>
</div>


