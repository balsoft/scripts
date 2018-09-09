#!/usr/bin/env python3
import imaplib
obj = imaplib.IMAP4_SSL('imap.gmail.com', 993)
obj.login("${secret.gmail.user}", "${secret.gmail.password}")
obj.select()
print(len(obj.search(None, 'unseen')[1][0].split()))
