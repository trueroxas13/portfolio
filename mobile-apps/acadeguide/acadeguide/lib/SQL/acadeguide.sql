DROP TABLE DISCUSSION_FORUM;
DROP TABLE FORUM_REPLY;

-- These are qureies to create tables used for supabase to create tabkes in the database.


CREATE TABLE DISCUSSION_FORUM(
    discussionId NUMBER(10) NOT NULL,
    userId VARCHAR2(20) NOT NULL,
    subject VARCHAR2(100) NOT NULL,
    description VARCHAR2(500) NOT NULL,
    date_time DATE DEFAULT SYSDATE NOT NULL,
    PRIMARY KEY (discussionId)
);

CREATE TABLE FORUM_REPLY(
    replyId NUMBER(10) NOT NULL,
    discussionId NUMBER(10) NOT NULL,
    userId VARCHAR2(20) NOT NULL,
    reply VARCHAR2(500) NOT NULL,
    date_time DATE DEFAULT SYSDATE NOT NULL,
    PRIMARY KEY (replyId),
    FOREIGN KEY (discussionId) REFERENCES DISCUSSION_FORUM(discussionId)
);




