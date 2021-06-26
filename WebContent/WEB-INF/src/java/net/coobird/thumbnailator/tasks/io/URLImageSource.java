package net.coobird.thumbnailator.tasks.io;

import java.awt.image.BufferedImage;
import java.io.IOException;
import java.net.MalformedURLException;
import java.net.Proxy;
import java.net.URL;

/**
 * An {@link ImageSource} which retrieves a source image from a URL.
 * 
 * @author coobird
 *
 */
public class URLImageSource extends AbstractImageSource<URL>
{
	/**
	 * The URL from which to retrieve the source image.
	 */
	private final URL url;
	
	/**
	 * The proxy to use to connect to the image URL.
	 * <p>
	 * If a proxy is not required, then this field will be {@code null}.
	 */
	private final Proxy proxy;

	/**
	 * Instantiates an {@link URLImageSource} with the URL from which the
	 * source image should be retrieved from.
	 * 
	 * @param url		URL to the source image.
	 * @throws NullPointerException		If the URL is null
	 */
	public URLImageSource(URL url)
	{
		super();
		
		if (url == null)
		{
			throw new NullPointerException("URL cannot be null.");
		}
		
		this.url = url;
		this.proxy = null;
	}
	
	/**
	 * Instantiates an {@link URLImageSource} with the URL from which the
	 * source image should be retrieved from.
	 * 
	 * @param url		URL to the source image.
	 * @throws NullPointerException		If the URL is null
	 * @throws MalformedURLException	If the URL is not valid.
	 */
	public URLImageSource(String url) throws MalformedURLException
	{
		super();
		
		if (url == null)
		{
			throw new NullPointerException("URL cannot be null.");
		}
		
		this.url = new URL(url);
		this.proxy = null;
	}
	
	/**
	 * Instantiates an {@link URLImageSource} with the URL from which the
	 * source image should be retrieved from, along with the proxy to use
	 * to connect to the aforementioned URL.
	 * 
	 * @param url		URL to the source image.
	 * @param proxy		Proxy to use to connect to the URL.
	 * @throws NullPointerException		If the URL and or the proxy is null
	 */
	public URLImageSource(URL url, Proxy proxy)
	{
		super();
		
		if (url == null)
		{
			throw new NullPointerException("URL cannot be null.");
		}
		else if (proxy == null)
		{
			throw new NullPointerException("Proxy cannot be null.");
		}
		
		this.url = url;
		this.proxy = proxy;
	}
	
	/**
	 * Instantiates an {@link URLImageSource} with the URL from which the
	 * source image should be retrieved from, along with the proxy to use
	 * to connect to the aforementioned URL.
	 * 
	 * @param url		URL to the source image.
	 * @param proxy		Proxy to use to connect to the URL.
	 * @throws NullPointerException		If the URL and or the proxy is null
	 * @throws MalformedURLException	If the URL is not valid.
	 */
	public URLImageSource(String url, Proxy proxy) throws MalformedURLException
	{
		super();
		
		if (url == null)
		{
			throw new NullPointerException("URL cannot be null.");
		}
		else if (proxy == null)
		{
			throw new NullPointerException("Proxy cannot be null.");
		}
		
		this.url = new URL(url);
		this.proxy = proxy;
	}

	public BufferedImage read() 
	{
		InputStreamImageSource source = null;
		BufferedImage img = null;
		try
		{
			if (proxy != null)
			{
				source = new InputStreamImageSource(url.openConnection(proxy).getInputStream());
			}
			else
			{
				source = new InputStreamImageSource(url.openStream());
			}
		
			source.setThumbnailParameter(param);
		
		
			img = source.read();
			
		}catch (IOException e) {
			if(source!=null)source=null;
				System.out.println("read IOException==>");
				try {
					throw new IOException("Could not obtain image from URL: " + url);
				} catch (IOException e1) {
					// TODO Auto-generated catch block
					if(source!=null)source=null;
				}			
		}catch (NullPointerException e) {
			if(source!=null)source=null;
				System.out.println("read NullPointerException==>");
				throw new NullPointerException("Could not obtain image from URL: " + url);
		}catch (ArrayIndexOutOfBoundsException e) {
			if(source!=null)source=null;
				System.out.println("read ArrayIndexOutOfBoundsException==>");	
				throw new ArrayIndexOutOfBoundsException("Could not obtain image from URL: " + url);			
		}catch (Exception e){
			if(source!=null)source=null;

		}finally{
			if(source!=null){
				this.inputFormatName = source.getInputFormatName();
			}
			if(source!=null){
				source=null;
			}
			
			if(img!=null){
				if(finishedReading(img)!=null){
					return finishedReading(img);
				}else{
					img = null;
					return null;
				}
				
			}else{
				img = null;
				return null;
			}
						
		}
		

	}

	/**
	 * Returns the URL from which the source image is retrieved from.
	 * 
	 * @return the url		The URL to the source image.s
	 */
	public URL getSource()
	{
		return url;
	}

	/**
	 * Returns the proxy to use when connecting to the URL to retrieve the
	 * source image.
	 * 
	 * @return the proxy	The proxy used to connect to a URL.
	 */
	public Proxy getProxy()
	{
		return proxy;
	}
}
