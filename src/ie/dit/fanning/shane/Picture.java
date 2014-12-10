package ie.dit.fanning.shane;

import java.util.Date;

import com.google.appengine.api.datastore.Key;  

import javax.jdo.annotations.IdGeneratorStrategy;  
import javax.jdo.annotations.PersistenceCapable;  
import javax.jdo.annotations.Persistent;  
import javax.jdo.annotations.PrimaryKey;

@PersistenceCapable 
public class Picture {
	@PrimaryKey
	@Persistent(valueStrategy = IdGeneratorStrategy.IDENTITY)
	private Key key;
	@Persistent
	private Date date;
	@Persistent
	private Boolean priv;
	@Persistent
	private String imgKey;
	@Persistent
	private String owner;
	
	public Picture(Boolean priv, String imgKey)
	{
		this.date = new Date();
		this.priv = priv;
		this.imgKey = imgKey;
	}
	public String getOwner()
	{
		return owner; 
	}
	public Date getDate()
	{
		return date; 
	}
	public Key getKey()
	{
		return key;
	}
	public String getImgKey()
	{
		return imgKey;
	}
	public Boolean getPriv()
	{
		return priv;
	}
	public void setImgKey(String k)
	{
		this.imgKey = k;
	}
	public void setPriv(Boolean p)
	{
		this.priv = p;
	}
}
