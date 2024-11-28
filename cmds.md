3.2.2 :004 > Profile.where(avatar_url: 'example.com/avatar.png').find_each do |profile|
3.2.2 :005 >   profile.update!(avatar_url: nil)
3.2.2 :006 > end