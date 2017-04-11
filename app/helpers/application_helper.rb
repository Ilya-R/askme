# (c) goodprogrammer.ru
#
# В этом файле мы можем писать вспомогательные методы (хелперы)
# для представлений (view) нашего приложения
module ApplicationHelper

  # Этот метод возвращает ссылку на автарку пользователя, если она у него есть
  # Или ссылку на дефолтную аватарку, которая лежит в app/assets/images
  def user_avatar(user)
    if user.avatar_url.present?
      user.avatar_url
    else
      asset_path 'avatar.jpg'
    end
  end


  # Хелпер, рисующий span тэг с иконкой из font-awesome
  def fa_icon(icon_class)
    content_tag 'span', '', class: "fa fa-#{icon_class}"
  end

  def user_id_from_question(question)
    User.find(question.questioning_user).username if question.questioning_user
  end

  def user_tabcolor
    if @user.tabcolor == 'yellow'
      'background: #e8f200'
    elsif @user.tabcolor == 'pink'
      'background: #FF08E7'
    end
  end
end
