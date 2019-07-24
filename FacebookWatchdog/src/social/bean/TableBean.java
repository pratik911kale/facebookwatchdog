package social.bean;

public class TableBean 
{
   int postId;
   String friendEmail;
   String displayed;
   
   public String getfriendEmail()
   {
  	 return friendEmail;
   }
   
   public void setfriendEmail(String friendEmail)
   {
  	 this.friendEmail = friendEmail;
   }
   
   public int getPostId()
   {
  	 System.out.println("getPostFId in likebean: "+postId);
  	 return postId;
   }
   
   public void setPostId(int postId)
   {
  	 System.out.println("setPostFId in likebean: "+postId);
  	 this.postId = postId;
   }
   
   public String getDisplayed()
   {
  	 return displayed;
   }
   
   public void setDisplayed(String displayed)
   {
  	 this.displayed = displayed;
   }
   
   
}
