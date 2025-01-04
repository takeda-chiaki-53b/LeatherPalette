class ProductImageUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  # storage :fog
  if Rails.env.production?
    storage :fog
  else
    storage :file
  end

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url(*args)
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end
  def default_url
    "no_image.png"
  end

  # Process files as they are uploaded:
  # process scale: [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process resize_to_fit: [50, 50]
  # end
  # 画像のリサイズと余白の追加
  process resize_and_pad: [ 1080, 1080, "#ffffff" ]

  # Add an allowlist of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_allowlist
  #   %w(jpg jpeg gif png)
  # end
  def extension_allowlist
    %w[ jpg jpeg gif png heic webp ]
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg"
  # end
  # WebPに変換
  process :convert_to_webp

  def convert_to_webp
    manipulate! do |img|
      img.format "webp"
      img
    end
  end

  # 拡張子を.webpで保存
  def filename
    super.chomp(File.extname(super)) + ".webp" if original_filename.present?
  end

  private

  # 画像のリサイズと余白の追加を行うメソッド
  def resize_and_pad(width, height, background = "#ffffff")
    manipulate! do |img|
      # 画像を指定サイズにリサイズ（アスペクト比を保つ）
      img.resize "#{width}x#{height}"

      # 指定サイズに合わせて余白を追加
      img.combine_options do |cmd|
        cmd.background background
        cmd.gravity "center"
        cmd.extent "#{width}x#{height}"
      end

      img
    end
  end
end
