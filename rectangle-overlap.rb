class Point
  attr_accessor :x, :y

  def initialize(x, y)
    @x = x
    @y = y

  end #initialize

end 


class Rect
  attr_accessor :ul, :lr, :ll, :ur


  def initialize(ul, lr)
    @ul = ul
    @lr = lr

    self.VerifyRect

    @ur = Point.new(@lr.x, @ul.y)
    @ll = Point.new(@ul.x, @lr.y)
  end #initialize



  def VerifyRect #check that it is a rectangle

    #rectangle coordinates should be valid -- upper left x should not be less than lower right x, etc. 
    if @ul.x >= @lr.x || @ul.y <= @lr.y 
      
      puts "Input coordinates not accurate for rectangle."
      #exit
      return false
    else
      return true
    end #if

  end #VerifyRect



  def GetAllPoints
    return [@ul, @lr, @ur, @ll]
  end #GetAllPoints


end #class Rect



class Overlap 
  attr_accessor :rec1, :rec2


  def initialize(rec1, rec2)

    @rec1 = rec1
    @rec2 = rec2

  end #initialize



  def RunOverlapEval

    if self.CheckCornerInside || self.CheckNonCornerOverlap 
      puts "Rectangles overlap." 
      return true
    else 
      puts "Rectangles do not overlap."
      return false
    end

  end #RunOverlapEval



  def CheckCornerInside
    
    if self.CheckCornerInsideHelper(@rec1, @rec2) || self.CheckCornerInsideHelper(@rec2, @rec1)
      return true
    else
      return false
    end #end if
  end #CheckCornerInside    
    


  def CheckCornerInsideHelper(r1, r2)

    r1.GetAllPoints.each do |i|

      if (i.x > r2.ll.x) && (i.x < r2.lr.x) && (i.y > r2.ll.y) && (i.y < r2.ul.y) 
        #rectangles overlap
        return true 
      end #if
      
    end #do 

    #rectangles do not overlap
    return false

  end #CheckCornerInsideHelper



  def CheckNonCornerOverlap

    if self.CheckNonCornerOverlapHelper(@rec1, @rec2) || self.CheckNonCornerOverlapHelper(@rec2, @rec1)
      return true
    else
      return false
    end #end if

  end # CheckNonCornerInside


  def CheckNonCornerOverlapHelper(r1, r2)
    
    if (r1.ll.x < r2.ll.x) && \
      ( \
        ( (r1.ll.y > r2.ll.y) && (r1.ll.y < r2.ul.y) ) || \
        ( (r1.ul.y > r2.ll.y) && (r1.ul.y < r2.ul.y) ) \
      ) \
      && (r1.lr.x > r2.ll.x) 
      #rectangles overlap
      return true 
    end #if

    #rectangles do not overlap
    return false

    
  end #CheckNonCornerOverlapHelper


end #end Overlap



# execution

#instatiate points for first rectangle
ul1 = Point.new(2,5)
lr1 = Point.new(9,3)

#instantiate points for second rectangle
ul2 = Point.new(5,7)
lr2 = Point.new(7,1)

#instantiate rectangles
rec1 = Rect.new(ul1, lr1)
rec2 = Rect.new(ul2, lr2)

#run program
a = Overlap.new(rec1, rec2)
a.RunOverlapEval
