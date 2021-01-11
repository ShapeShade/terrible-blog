module ApplicationHelper

  def gravatar_for(user, size = 80)
    image_tag("https://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(user.email)}?s=#{size}", alt: user.username, class: 'rounded shadow mx-auto d-block')
  end
end
