/*
      scripts.js
      external scripts for EUSFLAT homepage
*/
   // ---------------------------------------------------------
   // footer: print footline on every page in the same look
   //
   function footer()
   {
        var thisdate = new Date();
        document.write('Copyright &copy; ' + thisdate.getFullYear() + ' by ');
        writeMailTag('ulrich','bodenhofer.com','Ulrich Bodenhofer');
   }
   // ---------------------------------------------------------
   // writeMail: insert mailto: link
   //
   function writeMail(name, domain)
   {
        var address = name + '@' + domain;
        document.write('<A href="mailto:' + address + '">' + address + '</A>');
   }
   // ---------------------------------------------------------
   // writeMail: insert mailto: link
   //
   function writeMailTag(name, domain, linkText)
   {
        var address = name + '@' + domain;
        if (!linkText) linkText = address;
        document.write('<a href="mailto:' + address + '">' + linkText+ '</a>');
   }
   // ---------------------------------------------------------
   // writeMenu: primary secondary
   //
   function writeMenu(primary, secondary, prefix)
   {
        document.write('<table border="0" cellpadding="0" cellspacing="0" width="100" rules="rows">');
        document.write('<tr><td class="inv">menu</td></tr>');
        if(primary == 'home') document.write('<tr><td class="menuitemselected"><a class="menuitemselected" href="' + prefix + 'index.html">personal/cv</a></td></tr>');
        else document.write('<tr><td class="menuitem"><a class="menuitem" href="' + prefix + 'index.html">personal/cv</a></td></tr>');
        if(primary == 'research') document.write('<tr><td class="menuitemselected"><a class="menuitemselected" href="' + prefix + 'research.html">research</a></td></tr>');
        else document.write('<tr><td class="menuitem"><a class="menuitem" href="' + prefix + 'research.html">research</a></td></tr>');
    //  if(primary == 'teaching') document.write('<tr><td class="menuitemselected"><a class="menuitemselected" href="' + prefix + 'teaching.html">teaching</a></td></tr>');
    //  else document.write('<tr><td class="menuitem"><a class="menuitem" href="' + prefix + 'teaching.html">teaching</a></td></tr>');
        if(primary == 'publications') document.write('<tr><td class="menuitemselected"><a class="menuitemselected" href="' + prefix + 'publications/">publications</a></td></tr>');
        else document.write('<tr><td class="menuitem"><a class="menuitem" href="' + prefix + 'publications/index.html">publications</a></td></tr>');
        if(primary == 'software') document.write('<tr><td class="menuitemselected"><a class="menuitemselected" href="' + prefix + 'software.html">software</a></td></tr>');
        else document.write('<tr><td class="menuitem"><a class="menuitem" href="' + prefix + 'software.html">software</a></td></tr>');
        if(primary == 'music') document.write('<tr><td class="menuitemselected"><a class="menuitemselected" href="' + prefix + 'music.html">music</a></td></tr>');
        else document.write('<tr><td class="menuitem"><a class="menuitem" href="' + prefix + 'music.html">music</a></td></tr>');
        if(primary == 'private') document.write('<tr><td class="menuitemselected"><a class="menuitemselected" href="' + prefix + 'private.html">private</a></td></tr>');
        else document.write('<tr><td class="menuitem"><a class="menuitem" href="' + prefix + 'private.html">private</a></td></tr>');
        if(primary == 'contact') document.write('<tr><td class="menuitemselected"><a class="menuitemselected" href="' + prefix + 'contact.html">contact</a></td></tr>');
        else document.write('<tr><td class="menuitem"><a class="menuitem" href="' + prefix + 'contact.html">contact</a></td></tr>');
        document.write('<tr><td></td></tr>');
        document.write('</table><br>');
   }

