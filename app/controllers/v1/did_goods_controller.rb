module V1
    class DidGoodsController < ApiController

        def index
            @did_goods = DidGood.all
            render json: @did_goods
        end

        def get_users
            auth_token = request.headers['Authorization']
            @users = User.all.where.not(access_token:auth_token)
            render json: @users, only: [:id, :first_name, :last_name], methods: :full_name
        end

        def create
            auth_token = request.headers['Authorization']
            @sender = User.find_by(access_token:auth_token)
            @did_good = DidGood.new(sender_id:@sender.id,receiver_id:params[:receiver_id],description: params[:description])
            if @did_good.save
                render json: @did_good
            else
                render json: @did_good.errors.full_messages, status: :unprocessable_entity
            end
        end

        def myself
            auth_token = request.headers['Authorization']
            @user = User.find_by(access_token:auth_token)
            render json: @user, methods: [:full_name, :avatar_url], only: [:id, :first_name, :last_name, :email, :coins, :did_goods_sent, :did_goods_received]
        end

        def did_goods_received
            auth_token = request.headers['Authorization']
            @sender = User.find_by(access_token:auth_token)
            render json: @sender.did_goods.reverse, include: { receiver: { only: [:id, :first_name, :last_name, :email], methods: [:full_name, :avatar_url] }, sender: { only: [:id, :first_name, :last_name, :email], methods: [:full_name, :avatar_url] } }, only: [:id, :description]
        end
        
        def did_goods_sent
            auth_token = request.headers['Authorization']
            @sender = User.find_by(access_token:auth_token)
            render json: @sender.reverse_did_goods.reverse, include: { receiver: { only: [:id, :first_name, :last_name, :email], methods: [:full_name, :avatar_url] }, sender: { only: [:id, :first_name, :last_name, :email], methods: [:full_name, :avatar_url] } }, only: [:id, :description]
        end

        #all_time
        def top_receivers_all_time
            @top_users = User.order("users.did_goods_received DESC").limit(3)
            render json: @top_users
        end
        #all_time
        def top_senders_all_time
            @top_users = User.order("users.did_goods_sent DESC").limit(3)
            render json: @top_users
        end

        def ranking_received
            @ranking = User.all.sort_by {|user| user.did_goods_received_month}.reverse
            render json: @ranking, only: [:id, :first_name, :last_name, :email], methods: [:full_name, :did_goods_received_month, :avatar_url]
        end

        def ranking_sent
            @ranking = User.all.sort_by {|user| user.did_goods_sent_month}.reverse
            render json: @ranking, only: [:id, :first_name, :last_name, :email], methods: [:full_name, :did_goods_sent_month, :avatar_url]
        end


        private

        def did_goods_params
            params.require(:did_good).permit(:description,:receiver_id)
        end
    end

end
