class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy org ]

  # GET /users or /users.json
  def index
    respond_to do |format|
      format.csv do
        @users = User.all
        response.headers['Content-Type'] = 'text/csv'
      end
      format.html do
        @users = User.where("id > ?", params[:start_id] || 0).limit(100)
      end
    end
  end

  # GET /users/1 or /users/1.json
  def show
  end

  def org
    @org_csv_path = params[:all] == 'true' ? users_path(format: :csv) : org_user_path(@user, format: :csv)
    respond_to do |format|
      format.csv do
        response.headers['Content-Type'] = 'text/csv'
      end
      format.html
    end
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to user_url(@user), notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_url(@user), notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :email, :manager_id)
    end
end
