trigger sendEmail on contact (after insert, after update)
{             
                List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
                for(contact con : trigger.new)
                { 
                Messaging.EmailFileAttachment attach = new Messaging.EmailFileAttachment();
                attach.setContentType('application/pdf');
                attach.setFileName('contact.pdf');
               
                String body;
               
        body = '<html><h1 style=\"text-align:center;\">Contact Information</h1><br/><br/><table align=\"center\"><tr><td>contact Name</td><td>' + con.FirstName + '</td></tr><tr><td>Contact Phone</td><td>' + con.phone + '</td></tr><tr><td>Fax</td><td>' + con.Fax+ '</td></tr></table></html>';
                System.debug('HTML is ' + body);
               
                attach.Body = Blob.toPDF(body);
               
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                mail.setToAddresses(new String[] { con.Email });
                mail.setSubject('PDF Generation');
                mail.setHtmlBody('PFA');
                mail.setFileAttachments(new Messaging.EmailFileAttachment[] { attach });        
               
                mails.add(mail);
                }
                if(!mails.isEmpty())
                {
                Messaging.SendEmail(mails);
                }

}