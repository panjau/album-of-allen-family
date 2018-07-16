class PhotosController < ApplicationController
  before_action :set_photo, :only => [:show, :edit, :update, :destroy]

  def index
    @photos = Photo.all
  end

  def new
    @photo = Photo.new  
  end

  def create
    # 使用者輸入的資料存入photo_params這個物件中
    @photo = Photo.new(photo_params) 
    if @photo.save
      redirect_to photos_url
      puts "a"
    else
      puts "b"
      render  :action => :new
    end
  end

  def update
    if @photo.update_attributes(photo_params)
      redirect_to photo_path(@photo)
    else
      render  :action => :edit
    end
  end

  def destroy
    @photo.destroy
    redirect_to photos_url
  end
  private

  # photo_params是一個方法
  def photo_params  
    # 告訴控制器可以允許標題，日期，敘述，檔案位置這些參數被修改
    # 加上 require(:photo) 可以幫我們確認使用者上傳的參數名為 photo，以防邏輯出錯
    params.require(:photo).permit(:title, :date, :description, :file_location)
  end

  def set_photo
    @photo = Photo.find(params[:id])
  end

end
