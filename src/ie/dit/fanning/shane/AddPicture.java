package ie.dit.fanning.shane;

import java.io.IOException;  
import java.util.Map;  

import javax.jdo.PersistenceManager;  
import javax.servlet.http.HttpServlet;  
import javax.servlet.http.HttpServletRequest;  
import javax.servlet.http.HttpServletResponse;    

import com.google.appengine.api.blobstore.BlobKey;  
import com.google.appengine.api.blobstore.BlobstoreService;  
import com.google.appengine.api.blobstore.BlobstoreServiceFactory;  
  
public class AddPicture extends HttpServlet    
{  
   private BlobstoreService blobstoreService = BlobstoreServiceFactory.getBlobstoreService();  
      
   public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException  
   {   
	  String privy = req.getParameter("Private");
	  Boolean priv = Boolean.valueOf(privy); 
      Map<String, BlobKey> blobs = blobstoreService.getUploadedBlobs(req);  
      BlobKey blobKey = blobs.get("myPicture");  
      PersistenceManager pm = PMF.get().getPersistenceManager();     
      Picture picture = new Picture(priv, blobKey.getKeyString());  
   //persist  
      try{ pm.makePersistent(picture); }  
      finally{ pm.close(); }  
      resp.sendRedirect("home.jsp");  
   }  
}  
