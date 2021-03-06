class UsersController < ApplicationController

  # инициализируем объект юзера для экшенов кроме :index, :create, :new
  before_action :load_user, except: [:index, :create, :new]

  # проверяем имеет ли юзер доступ к экшену
  before_action :authorize_user, except: [:index, :new, :create, :show]

  # Это действие отзывается, когда пользователь заходит по адресу
  # /users
  def index
    @users = User.all
  end

  def new
    redirect_to root_url, alert: 'Вы уже залогинены' if current_user.present?
    @user = User.new
  end

  def create
    redirect_to root_url, alert: 'Вы уже залогинены' if current_user.present?

    @user = User.new(user_params)

    if @user.save
      redirect_to root_url, notice: 'Пользователь успешно зарегестрирован!'
      session[:user_id] = @user.id
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: 'Данные обновлены'
    else
      render 'edit'
    end
  end

  # Это действие отзывается, когда пользователь заходит по адресу
  # /users/:id, например /users/1
  def show
    @questions = @user.questions.order(created_at: :desc)

    @new_question = @user.questions.build

    @questions_count = @questions.count
    @answers_count = @questions.where.not(answer: nil).count
    @unanswered_count = @questions_count - @answers_count
  end

  def destroy
    @user.destroy
    redirect_to root_path, notice: 'Юзер удален, пока-пока!'
  end


  private

  # если загруженный из базы юзер и текущий залогиненный не совпадают - посылаем его
  def authorize_user
    reject_user unless @user == current_user
  end

  # загружаем из базы запрошенного юзера
  def load_user
    @user ||= User.find params[:id]
  end

  # явно задаем список разрешенных параметров для модели user
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation,
                                 :name, :username, :avatar_url, :tabcolor)
  end
end
