class V1::Resources::UsersController < ApplicationController
  #before_action :authenticate_user!, except: [:new]
  before_action :set_user, except: [:all, :new]
  
  # GET /v1/resources/users/all
  # GET /v1/resources/users/all.json
  def all
    @users = User.all
    respond_to do |format|
      if !@users.empty?
        format.html { render :all }
        format.json { render json: @users, status: :ok }
      else
        format.html { render(file: Rails.root.join('public', '204'), :formats => [:html], status: 204, layout: false) }
        format.json { head :no_content }
      end
    end
  end

  # GET /v1/resources/users/:username
  # GET /v1/resources/users/:username.json
  def show
    respond_to do |format|
      if @user
        format.html { render :show }
        format.json { render json: @user, status: :ok }
      else
        format.html { render(file: Rails.root.join('public', '204'), :formats => [:html], status: 204, layout: false) }
        format.json { head :no_content }
      end
    end
  end

  # POST /v1/resources/users/new
  # POST /v1/resources/users/new.json
  def new
    respond_to do |format|
      @user = User.new(user_params)
      if @user.save
        format.html { redirect_to v1_resources_users_path(username: @user.username), notice: 'User was added.' }
        format.json { render json: @user, status: :created}
      else
        format.html { render(file: Rails.root.join('public', '422'), :formats => [:html], status: 422, layout: false) }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /v1/resources/users/:username/update
  # PATCH/PUT /v1/resources/users/:username/update.json
  def update
     respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to v1_resources_users_path(username: @user.username), notice: 'User was updated.' }
        format.json { render json: @user, status: :ok }
      else
        format.html { render(file: Rails.root.join('public', '422'), :formats => [:html], status: 422, layout: false) }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /v1/resources/users/:username/delete
  # DELETE /v1/resources/users/:username/delete.json
  def delete
    @user.destroy
    respond_to do |format|
      format.html { redirect_to v1_resources_users_all_path, notice: 'User was deleted.' }
      format.json { head :no_content }
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find_by(username: params[:username])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :sign_in_count, :current_sign_in_at, :last_sign_in_at, :current_sign_in_ip, :last_sign_in_ip, :confirmation_token, :confirmed_at, :confirmation_sent_at, :unconfirmed_email, :failed_attempts, :unlock_token, :locked_at, :created_at, :updated_at, :username)
    end
end
