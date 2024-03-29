module ApplicationHelper
  def map_if
    if current_page?(controller: 'fishes', action: 'index')
      'flex flex-col'
    elsif current_page?(controller: 'static_pages', action: 'top')
      ''
    else
      'px-5'
    end
  end

  def default_meta_tags
    {
      site: 'FippoMap (フィッポマップ)',
      # title: '',
      reverse: true,
      separator: '|', # Webサイト名とページタイトルを区切るために使用されるテキスト
      description: '文字だけの情報ではどこで魚が釣れるか分かりづらい、釣った魚の情報を簡単に記録できるツールがないといった悩みを持った人に、 視覚的に投稿、閲覧、管理できる価値を与える、マップに特化した釣り人のためのSNSです!!',
      keywords: 'fippo map,フィッポマップ,魚釣り', # キーワードを「,」区切りで設定する
      canonical: request.original_url, # 優先するurlを指定する
      noindex: !Rails.env.production?,
      icon: [ # favicon、apple用アイコンを指定する
        { href: image_url('favicon.png') },
        { href: image_url('apple_icon.png'), rel: 'apple-touch-icon', sizes: '180x180', type: 'image/jpg' }
      ],
      og: {
        site_name: 'FippoMap (フィッポマップ)',
        title: 'FippoMap (フィッポマップ) - 釣った魚の情報を簡単に記録できるマップに特化した釣り人のためのSNSです。',
        description: '文字だけの情報ではどこで魚が釣れるか分かりづらい、釣った魚の情報を簡単に記録できるツールがないといった悩みを持った人に、 視覚的に投稿、閲覧、管理できる価値を与える、マップに特化した釣り人のためのSNSです!!',
        type: 'website',
        url: request.original_url,
        image: image_url('ogp.png'),
        locale: 'ja_JP'
      },
      twitter: {
        card: 'summary_large_image',
        site: '@takuma1996300'
      },
      fb: {
        app_id: '941287830402028'
      }
    }
  end

  def unchecked_notifications
    @notifications = current_user.passive_notifications.where(checked: false)
  end
end
