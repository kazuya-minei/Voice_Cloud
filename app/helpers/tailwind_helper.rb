module TailwindHelper
  def menuList 
    'list-none leading-none p-4 border-b bg-gray-300 bg-opacity-50  duration-300 hover:bg-opacity-75'
  end

  def menuLink
    'no-underline text-base px-8'
  end

  def btnLink
   'transition duration-200 ease-in-btn block max-w-btn no-underline rounded-btn 
    py-btnTB px-btnRL text-add-btn hover:text-add-btnHover shadow-btn hover:shadow-hover m-auto'
  end

  def btn
    'text-center w-4/5 md:w-2/5 mx-10% md:m-btnMd'
  end

  def page
    'font-sans text-sm rounded w-full max-w-md mx-auto px-8 pt-10 md:pt-72 lg:pt-32 pb-8 text-add-text'
  end

  def pageTitle
    'text-add-text text-xl mb-8 text-center font-semibold lg:text-2xl'
  end

  def form 
    'relative rounded mb-4 appearance-none label-floating'
  end

  def formInput
    'shadow-inner w-full py-2 px-3 text-gray-700 leading-normal rounded 
    bg-add-base placeholder-add-text placeholder-opacity-75 border-none text-add-text'
  end

  def formBtn
    'flex items-center justify-between'
  end

  def submit
    'transision duration-200 ease-in-btn hover:text-add-btnHover 
     hover:shadow-hover block no-underline rounded-btn w-2/5
     cursor-pointer text-add-text py-2 mx-btnPx shadow-btn bg-add-bg'
  end

  def subTitle
    'text-base font-semibold text-center text-base'
  end

  def item
    'bg-add-base rounded mb-4 p-2'
  end

  def titleUnderLine
    'border-b-2 border-add-text border-opacity-25'
  end

end