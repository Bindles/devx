<%# profiles/edit.html.erb (view): %>
<h1>Edit Profile</h1>
<%= form_with model: @user, url: user_profile_path(@user), method: :patch, local: true, html: { multipart: true } do |form| %>
  <div class="form-group">
    <%= form.label :username %>
    <%= form.text_field :username, class: "form-control", value: @user.username %>
  </div>

  <%= form.fields_for :profile, @profile do |profile_form| %>
    <div class="form-group">
      <%= profile_form.label :bio %>
      <%= profile_form.text_area :bio, class: "form-control", value: @profile.bio %>
    </div>
    

  <div class="form-group">
    <%= profile_form.label :avatar_url %>
    <div id="image-preview-container">
      <img id="image-preview" src="<%= @profile.avatar_url.presence || '#' %>" style="display: <%= @profile.avatar_url.present? ? 'block' : 'none' %>; max-width: 150px; margin-bottom: 10px;" alt="Preview">
    </div>
    <%= profile_form.file_field :avatar_url, class: "form-control", id: "image-upload" %>
  </div>
  <% end %>

  <%= form.submit "Save Changes", class: "btn btn-success" %>
  <%= link_to "Cancel", user_profile_path(@user), class: "btn btn-secondary" %>
<% end %>





<script>
document.addEventListener("DOMContentLoaded", () => {
  const fileInput = document.getElementById("image-upload");
  const previewImage = document.getElementById("image-preview");
  const previewContainer = document.getElementById("image-preview-container");

  if (fileInput) {
    fileInput.addEventListener("change", (event) => {
      const file = event.target.files[0];

      if (file) {
        const reader = new FileReader();

        reader.onload = (e) => {
          previewImage.src = e.target.result; // Set the image source to the base64 data
          previewImage.style.display = "block"; // Show the image preview
        };

        reader.readAsDataURL(file); // Read the file and trigger the onload
      } else {
        previewImage.src = "#";
        previewImage.style.display = "none"; // Hide the image preview
      }
    });
  }
});

</script>