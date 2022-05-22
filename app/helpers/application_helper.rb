module ApplicationHelper
  # ページごとの完全なタイトルを返します。
  def full_title(page_title = '')
    base_title = "Ruby on Rails Tutorial Sample App"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end
end

  # 表示用のリサイズ済み画像を返す
  def resize_image(image)
    image.variant(resize_to_limit: [500, 500])
  end
