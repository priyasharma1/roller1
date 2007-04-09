/*
 * Created on May 26, 2003
 */
package org.roller.model;

import org.apache.velocity.context.Context;
import org.roller.RollerException;
import org.roller.pojos.WeblogEntryData;
import org.roller.pojos.WebsiteData;

/**
 * Interface for Roller weblog entry plugins.
 * Plugin objects operate on the text field of a weblog entry object. 
 * Plugins save state and may not be thread-safe.
 * Consequently, new plugin objects are created for each request.
 * This interface has no dependency on Servlet classes, but page plugins may.
 *
 * Existing implementations:
 * autogenerate links from Bookmarks (BookmarkPlugin),
 * obfuscate email addresses (EmailObfuscator), truncate an Entry at 250
 * characters and add a Read More... link (ReadMorePlugin), and transform
 * 'simple markup' according to several schemes (JSPWiki, Radeox, Textile).
 * See the "contrib" directory for these implementations.
 *
 * @author David M Johnson
 */
public interface PagePlugin {
    public String name = "PagePlugin";
    
    /**
     * Plugins can this as an opportunity to add any required objects
     * to the RollerRequest and the VelocityContext.
     * @param website     Website being processed
     * @param config      javax.servlet.ServletContext (or null if running outside webapp)
     * @param baseURL     Base URL of Roller site 
     * @param ctx         Plugins may place objects into the Velocity Context.
     */
    public void init(
            WebsiteData website,
            Object servletContext,
            String baseURL,
            Context ctx) throws RollerException;
    
    /**
     * Apply plugin to content of specified WeblogEntry.  The WeblogEntryData
     * is actually a copy of the real thing, so that changes made via
     * entry.setText() are not persisted.  Notice this; no changes made
     * to the entry will be persisted.
     * Some Plugins are only suited to rendering during Page display
     * (not when generating RSS or Trackback content or in the
     * Entry Preview) - ReadMorePlugin is an example of such a case.
     * If the skipFlag is set to 'true' it merely returns the
     * unadorned contents of entry.getText().
     *
     * @param entry WeblogEntry to which plugin should be applied.
     * @param skipFlag Should processing be skipped.
     * @return Results of applying plugin to entry.
     */
    public String render(WeblogEntryData entry, boolean skipFlag);
    
    /**
     * Apply plugin to content of specified String.  Some plugins
     * may require interaction with an Entry to do its job (such
     * as the BookmarkPlugin) and will simply return the String
     * that was passed in.
     *
     * @param str String to which plugin should be applied.
     * @return Results of applying plugin to string.
     */
    public String render(String str);
    
    /**
     * Must implement toString(), returning the human-friendly
     * name of this Plugin.  This is what users will see.
     * @return The human-friendly name of this Plugin.
     */
    public String toString();
    
    /**
     * Returns the human-friendly name of this Plugin.
     * This is what users will see.
     * @return The human-friendly name of this Plugin.
     */
    public String getName();
    
    /**
     * Briefly describes the function of the Plugin. May
     * contain HTML.
     * @return A brief description of the Plugin.
     */
    public String getDescription();
}