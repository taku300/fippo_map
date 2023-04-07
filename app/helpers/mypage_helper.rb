module MypageHelper
  def current_mypage(action)
    current_page?(controller: 'mypage', action:) ? 'bg-indigo-200 hover:bg-indigo-300 border-indigo-800 text-indigo-500 border-b-2 py-4 px-3' : 'hover:bg-indigo-100 text-slate-500 py-4 px-3'
  end
end
