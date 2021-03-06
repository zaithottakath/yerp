class BusinessesController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]
  # GET /businesses
  # GET /businesses.json

  def index
    tag_cloud
    if params[:tag] || params[:sort]
      sort_and_filter_list
    elsif params[:q]
      @businesses = Business.search(params[:q])
      @header = "Search Results for #{params[:q].downcase}"
    else
      @businesses = Business.all
      @header = 'All Businesses'
    end


    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @businesses }
    end
  end

  # GET /businesses/1
  # GET /businesses/1.json
  def show
    @business = Business.find(params[:id])
    @comment = Comment.new
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @business }
    end
  end

  # GET /businesses/new
  # GET /businesses/new.json
  def new
    @business = Business.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @business }
    end
  end

  # GET /businesses/1/edit
  def edit
    @business = Business.find(params[:id])
  end


  # POST /businesses
  # POST /businesses.json
  def create
    @business = Business.new(params[:business])

    respond_to do |format|
      if @business.save
        format.html { redirect_to @business, notice: 'Business was successfully created.' }
        format.json { render json: @business, status: :created, location: @business }
      else
        format.html { render action: "new" }
        format.json { render json: @business.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /businesses/1
  # PUT /businesses/1.json
  def update
    @business = Business.find(params[:id])

    respond_to do |format|
      if @business.update_attributes(params[:business])
        format.html { redirect_to @business, notice: 'Business was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @business.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /businesses/1
  # DELETE /businesses/1.json
  def destroy
    @business = Business.find(params[:id])
    @business.destroy

    respond_to do |format|
      format.html { redirect_to businesses_url }
      format.json { head :no_content }
    end
  end
private
  def tag_cloud
    @tags = Business.tag_counts_on(:tags)
  end

  def sort_and_filter_list
    order = 'rating'
    order = 'rating_count' if params[:sort] == 'most_reviewed'
    order = 'created_at' if params[:sort] == 'new'
    if params[:tag]
      @businesses = Business.tagged_with(params[:tag]).order("#{order} DESC")
      @header = "Businesses tagged with '#{params[:tag]}'"

    else
      @businesses = Business.find(:all, order:"#{order} DESC")
      @header = 'Businesses'
    end
  end


end
