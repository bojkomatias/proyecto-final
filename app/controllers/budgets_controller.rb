class BudgetsController < ApplicationController
  before_action :set_budget, only: %i[ show edit update destroy ]
  load_and_authorize_resource
  # GET /budgets or /budgets.json
  def index
    @budgets = Budget.all
    @budgets = Budget.order(params[:by] + " " + params[:order]).page params[:page] if params[:sort] == "true"
    @budgets = Budget.order(:id).page params[:page]
  end

  # GET /budgets/1 or /budgets/1.json
  def show
  end

  # GET /budgets/new
  def new
    @budget = Budget.new
  end

  # GET /budgets/1/edit
  def edit
  end

  # POST /budgets or /budgets.json
  def create
    @budget = Budget.new(budget_params)
    respond_to do |format|
      if @budget.save
        
        if !params[:budget][:items].nil?
          params[:budget][:items].each do |f| 
            Item.where(["id = #{f}"]).first.update(budget_id: @budget.id)
          end
        end
        
        format.html { redirect_to budgets_path, notice: "Budget was successfully created." }
        format.json { render :show, status: :created, location: @budget }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @budget.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /budgets/1 or /budgets/1.json
  def update
    respond_to do |format|
      if @budget.update(budget_params)
        Item.where(["budget_id = #{params[:id]}"]).update_all(budget_id: nil)
        if !params[:budget][:items].nil?
          params[:budget][:items].each do |f| 
            Item.where(["id = #{f}"]).first.update(budget_id: params[:id])
          end
        end
        format.html { redirect_to budgets_path, notice: "Budget was successfully updated." }
        format.json { render :show, status: :ok, location: @budget }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @budget.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /budgets/1 or /budgets/1.json
  def destroy
    @budget.destroy
    respond_to do |format|
      format.html { redirect_to budgets_url, notice: "Budget was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_budget
      @budget = Budget.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def budget_params
      params.require(:budget).permit(:name, :from, :expires, :user_id, items: [:id])
    end
end
