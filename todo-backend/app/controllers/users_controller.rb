class UsersController < ApplicationController
    #GET /users
     def index
        render json: User.all, status: :ok #200
     end

    #GET /users/[:id]
    def show
        user=User.find_by(id: params[:id])
        if user
            render json: user, status: :ok
        else
            render json: {error: "User not found"}, status: :not_found #404
        end
    end

    #POST /users
     
    def create
        user=User.create(user_params)

        if user.valid?
            render json: user, status: :created
        else
            render json: {errors: user.errors.full_messages},
            status: :unprocessable_entity #422
        end
    end

    #PUT/PATCH /users/[:id]

    def update
        user= User.find_by(id: params[:id])
        if user
            user.update(user_params)
            render json: user, status: :accepted #202
        else
            render json: {error: "User not found"}, status: :not_found #404
        end
    end

    #DELETE /users/[:id]

    def destroy
        user=User.find_by(id: params[:id])

        if user
            user.destroy
            head :no_content
        else
            render json: {error: "User not found"}, status: :not_found
        end
    end

    private
    def user_params
        params.permit(
            :fname, :lname, :username, :email, :password, :password_confirmation
        )
    end
end
