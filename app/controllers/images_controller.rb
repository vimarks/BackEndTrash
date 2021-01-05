class ImagesController < ApplicationController
  skip_before_action :authorized, only: [:index]
  before_action :set_image, only: [:show, :update, :destroy]

  # GET /images
  def index
    @images = Image.all
    # get random confirmed piece of trash
    users = User.all
    confirmedTrashes = Trash.all.select { |trash| trash.cleaned === "confirmed"}

    randomTrash1 = confirmedTrashes.sample
    randomTrash2 = confirmedTrashes.select { |trash| trash.id != randomTrash1.id}.sample
    randomTrash3 = confirmedTrashes.select { |trash| trash.id != randomTrash1.id && trash.id != randomTrash2.id}.sample\

    randomReporter1 = users.select { |user| user.id === randomTrash1.reporter_id }[0]
    randomReporter2 = users.select { |user| user.id === randomTrash2.reporter_id }[0]
    randomReporter3 = users.select { |user| user.id === randomTrash3.reporter_id }[0]

    randomCleaner1 = users.select { |user| user.id === randomTrash1.cleaner_id }[0]
    randomCleaner2 = users.select { |user| user.id === randomTrash2.cleaner_id }[0]
    randomCleaner3 = users.select { |user| user.id === randomTrash3.cleaner_id }[0]

    puts "RANDOM*************** #{randomTrash1}#{randomTrash2}#{randomTrash3}"
    beforeImage1 = @images.select { |image| image.trash_id === randomTrash1.id}
                       .select { |image| image.image_type === "before"}
    afterImage1 = @images.select { |image| image.trash_id === randomTrash1.id}
                         .select { |image| image.image_type === "after"}

    beforeImage2 = @images.select { |image| image.trash_id === randomTrash2.id}
                          .select { |image| image.image_type === "before"}
    afterImage2 = @images.select { |image| image.trash_id === randomTrash2.id}
                         .select { |image| image.image_type === "after"}

    beforeImage3 = @images.select { |image| image.trash_id === randomTrash3.id}
                          .select { |image| image.image_type === "before"}
    afterImage3 = @images.select { |image| image.trash_id === randomTrash3.id}
                         .select { |image| image.image_type === "after"}
    render json: {
      randomTrash1: randomTrash1,
      beforeImage1: beforeImage1[0],
      afterImage1: afterImage1[0],
      randomReporter1: randomReporter1.username,
      randomCleaner1: randomCleaner1.username,

      randomTrash2: randomTrash2,
      beforeImage2: beforeImage2[0],
      afterImage2: afterImage2[0],
      randomReporter2: randomReporter2.username,
      randomCleaner2: randomCleaner2.username,

      randomTrash3: randomTrash3,
      beforeImage3: beforeImage3[0],
      afterImage3: afterImage3[0],
      randomReporter3: randomReporter3.username,
      randomCleaner3: randomCleaner3.username,
    }
  end

  # GET /images/1
  def show
    render json: @image
  end

  # POST /images
  def create
    url = params["url"]
    image_type = params["image_type"]
    trash_id = params["trash_id"]
    @image = Image.new(
      url: url,
      image_type: image_type,
      trash_id: trash_id
    )

    if @image.save
      render json: @image, status: :created, location: @image
    else
      render json: @image.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /images/1
  def update
    if @image.update(image_params)
      render json: @image
    else
      render json: @image.errors, status: :unprocessable_entity
    end
  end

  # DELETE /images/1
  def destroy
    @image.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_image
      @image = Image.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def image_params
      params.require(:image).permit(:type, :URL, :trash_id)
    end
end
