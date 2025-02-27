-- Database: EDUMentor

-- DROP DATABASE IF EXISTS "EDUMentor";

-- Step 1: Check if the database exists
SELECT 1
FROM pg_database
WHERE datname = 'EDUMentor';

--19 Table: public.Role

-- DROP TABLE IF EXISTS public."Role";

CREATE TABLE IF NOT EXISTS public."Role"
(
    "RoleID" serial NOT NULL,
    "Role" text COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "Role_pkey" PRIMARY KEY ("RoleID")
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."Role"
    OWNER to adminadmin;


--1 Table: public.User

-- DROP TABLE IF EXISTS public."User";

CREATE TABLE IF NOT EXISTS public."User"
(
    "UserID" serial NOT NULL,
    "Email" text COLLATE pg_catalog."default" NOT NULL UNIQUE,
    "FirstName" character varying(30) COLLATE pg_catalog."default" NOT NULL,
    "LastName" character varying(30) COLLATE pg_catalog."default" NOT NULL,
    "Role" integer NOT NULL,
    "Password" text COLLATE pg_catalog."default",
    "IsDeleted" boolean NOT NULL DEFAULT false,
    CONSTRAINT "User_pkey" PRIMARY KEY ("UserID"),
    CONSTRAINT "User_fkey" FOREIGN KEY ("Role")
        REFERENCES public."Role" ("RoleID") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."User"
    OWNER to adminadmin;

--2 Table: public.OnlineDonor

-- DROP TABLE IF EXISTS public."OnlineDonor";

CREATE TABLE IF NOT EXISTS public."OnlineDonor"
(
    "OnlineDonorID" serial NOT NULL,
    "NumberofDonations" smallint NOT NULL,
    CONSTRAINT "OnlineDonor_pkey" PRIMARY KEY
(
    "OnlineDonorID"
),
    CONSTRAINT "OnlineDonorForeignKey" FOREIGN KEY
(
    "OnlineDonorID"
)
    REFERENCES public."User"
(
    "UserID"
) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    )
    TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."OnlineDonor"
    OWNER to adminadmin;


--3 Table: public.Admin

-- DROP TABLE IF EXISTS public."Admin";

CREATE TABLE IF NOT EXISTS public."Admin"
(
    "AdminID" serial NOT NULL,
    "Status" boolean NOT NULL,
    CONSTRAINT "Admin_pkey" PRIMARY KEY
(
    "AdminID"
),
    CONSTRAINT "Admin_fkey" FOREIGN KEY
(
    "AdminID"
)
    REFERENCES public."User"
(
    "UserID"
) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    )
    TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."Admin"
    OWNER to adminadmin;


--4 Table: public.Mentor

-- DROP TABLE IF EXISTS public."Mentor";

CREATE TABLE IF NOT EXISTS public."Mentor"
(
    "MentorID" serial NOT NULL,
    CONSTRAINT "Mentor_pkey" PRIMARY KEY
(
    "MentorID"
),
    CONSTRAINT "Mentor_fkey" FOREIGN KEY
(
    "MentorID"
)
    REFERENCES public."User"
(
    "UserID"
) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    )
    TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."Mentor"
    OWNER to adminadmin;


--5 Table: public.Mentee

-- DROP TABLE IF EXISTS public."Mentee";

CREATE TABLE IF NOT EXISTS public."Mentee"
(
    "MenteeID" serial NOT NULL,
    "LearningHours" double precision NOT NULL,
    "NumberOfAttandedSessions" integer NOT NULL,
    CONSTRAINT "Mentee_pkey" PRIMARY KEY
(
    "MenteeID"
),
    CONSTRAINT "Mentee_fkey" FOREIGN KEY
(
    "MenteeID"
)
    REFERENCES public."User"
(
    "UserID"
) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    )
    TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."Mentee"
    OWNER to adminadmin;


--6 Table: public.OnlineDonation

-- DROP TABLE IF EXISTS public."OnlineDonation";

CREATE TABLE IF NOT EXISTS public."OnlineDonation"
(
    "DonationID" serial NOT NULL,
    "Amount" double precision NOT NULL,
    "PaymentType" smallint NOT NULL,
    "AmountCharged" double precision NOT NULL,
    "IsDeleted" boolean NOT NULL DEFAULT false,
    CONSTRAINT "OnlineDonation_pkey" PRIMARY KEY
(
    "DonationID"
)
    )
    TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."OnlineDonation"
    OWNER to adminadmin;


--7 Table: public.Session

-- DROP TABLE IF EXISTS public."Session";

CREATE TABLE IF NOT EXISTS public."Session"
(
    "SessionID" bigserial NOT NULL,
    "SessionName" text COLLATE pg_catalog."default" NOT NULL,
    "Duration" double precision NOT NULL,
    "Date" timestamp without time zone NOT NULL,
    "IsDeleted" boolean NOT NULL DEFAULT false,
    CONSTRAINT "Session_pkey" PRIMARY KEY
(
    "SessionID"
)
    )
    TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."Session"
    OWNER to adminadmin;

--8 Table: public.Feedback

-- DROP TABLE IF EXISTS public."Feedback";

CREATE TABLE IF NOT EXISTS public."Feedback"
(
    "FeedbackID" bigserial NOT NULL,
    "Comment" text COLLATE pg_catalog."default" NOT NULL,
    "Stars" smallint NOT NULL,
    "IsDeleted" boolean NOT NULL DEFAULT false,
    CONSTRAINT "Feedback_pkey" PRIMARY KEY
(
    "FeedbackID"
)
    )
    TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."Feedback"
    OWNER to adminadmin;


--9 Table: public.Topics

-- DROP TABLE IF EXISTS public."Topics";

CREATE TABLE IF NOT EXISTS public."Topics"
(
    "TopicsID" serial NOT NULL,
    "TopicsName" text COLLATE pg_catalog."default" NOT NULL,
    "IsDeleted" boolean NOT NULL DEFAULT false,
    CONSTRAINT "Topics_pkey" PRIMARY KEY
(
    "TopicsID"
)
    )
    TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."Topics"
    OWNER to adminadmin;


--10 Table: public.MT_InterestedIn

-- DROP TABLE IF EXISTS public."MT_InterestedIn";

CREATE TABLE IF NOT EXISTS public."MT_InterestedIn"
(
    "MentorID"
    integer
    NOT
    NULL,
    "TopicsID"
    integer
    NOT
    NULL,
    "IsDeleted"
    boolean
    NOT
    NULL
    DEFAULT false,
    CONSTRAINT
    "MT_InterestedIn_pkey"
    PRIMARY
    KEY
(
    "MentorID",
    "TopicsID"
),
    CONSTRAINT "MT_InterestedIn_MID_fkey" FOREIGN KEY
(
    "MentorID"
)
    REFERENCES public."Mentor"
(
    "MentorID"
) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION,
    CONSTRAINT "MT_InterestedIn_TID_fkey" FOREIGN KEY
(
    "TopicsID"
)
    REFERENCES public."Topics"
(
    "TopicsID"
) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    )
    TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."MT_InterestedIn"
    OWNER to adminadmin;


--11 Table: public.Mentor_Availability

-- DROP TABLE IF EXISTS public."Mentor_Availability";

CREATE TABLE IF NOT EXISTS public."Mentor_Availability"
(
    "MentorID"
    integer
    NOT
    NULL,
    "Availability"
    timestamp
    without
    time
    zone
    NOT
    NULL,
    "AvailabilityDuration"
    double precision
    NOT
    NULL,
    "IsDeleted"
    boolean
    NOT
    NULL
    DEFAULT false,
    CONSTRAINT
    "Mentor_Availability_pkey"
    PRIMARY
    KEY
(
    "MentorID",
    "Availability",
    "AvailabilityDuration"
),
    CONSTRAINT "MentorAvailability_fkey" FOREIGN KEY
(
    "MentorID"
)
    REFERENCES public."Mentor"
(
    "MentorID"
) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    )
    TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."Mentor_Availability"
    OWNER to adminadmin;


--12 Table: public.MTT_InterestedIn

-- DROP TABLE IF EXISTS public."MTT_InterestedIn";

CREATE TABLE IF NOT EXISTS public."MTT_InterestedIn"
(
    "MenteeID"
    integer
    NOT
    NULL,
    "TopicsID"
    integer
    NOT
    NULL,
    "IsDeleted"
    boolean
    NOT
    NULL
    DEFAULT false,
    CONSTRAINT
    "MTT_InterestedIn_pkey"
    PRIMARY
    KEY
(
    "MenteeID",
    "TopicsID"
),
    CONSTRAINT "MTT_InterestedIn_MID_fkey" FOREIGN KEY
(
    "MenteeID"
)
    REFERENCES public."Mentee"
(
    "MenteeID"
) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION,
    CONSTRAINT "MTT_InterestedIn_TID_fkey" FOREIGN KEY
(
    "TopicsID"
)
    REFERENCES public."Topics"
(
    "TopicsID"
) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    )
    TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."MTT_InterestedIn"
    OWNER to adminadmin;


--13 Table: public.ODD_Makes

-- DROP TABLE IF EXISTS public."ODD_Makes";

CREATE TABLE IF NOT EXISTS public."ODD_Makes"
(
    "OnlineDonorID"
    integer
    NOT
    NULL,
    "DonationID"
    integer
    NOT
    NULL,
    "Date"
    timestamp
    with
    time
    zone
    NOT
    NULL,
    CONSTRAINT
    "ODD_Makes_pkey"
    PRIMARY
    KEY
(
    "OnlineDonorID",
    "DonationID"
),
    CONSTRAINT "ODD_Makes_DID_fkey" FOREIGN KEY
(
    "DonationID"
)
    REFERENCES public."OnlineDonation"
(
    "DonationID"
) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION,
    CONSTRAINT "ODD_Makes_ODID_fkey" FOREIGN KEY
(
    "OnlineDonorID"
)
    REFERENCES public."OnlineDonor"
(
    "OnlineDonorID"
) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    )
    TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."ODD_Makes"
    OWNER to adminadmin;


--14 Table: public.AS_Makes

-- DROP TABLE IF EXISTS public."AS_Makes";

CREATE TABLE IF NOT EXISTS public."AS_Makes"
(
    "AdminID"
    integer
    NOT
    NULL,
    "SessionID"
    bigint
    NOT
    NULL,
    CONSTRAINT
    "AS_Makes_pkey"
    PRIMARY
    KEY
(
    "AdminID",
    "SessionID"
),
    CONSTRAINT "AS_Makes_AID_fkey" FOREIGN KEY
(
    "AdminID"
)
    REFERENCES public."Admin"
(
    "AdminID"
) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION,
    CONSTRAINT "AS_Makes_SID_fkey" FOREIGN KEY
(
    "SessionID"
)
    REFERENCES public."Session"
(
    "SessionID"
) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    )
    TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."AS_Makes"
    OWNER to adminadmin;


--15 Table: public.SMTT_Takes

-- DROP TABLE IF EXISTS public."SMTT_Takes";

CREATE TABLE IF NOT EXISTS public."SMTT_Takes"
(
    "SessionID"
    bigint
    NOT
    NULL,
    "MenteeID"
    integer
    NOT
    NULL,
    CONSTRAINT
    "SMTT_Takes_pkey"
    PRIMARY
    KEY
(
    "SessionID",
    "MenteeID"
),
    CONSTRAINT "SMTT_Takes_MID_fkey" FOREIGN KEY
(
    "MenteeID"
)
    REFERENCES public."Mentee"
(
    "MenteeID"
) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION,
    CONSTRAINT "SMTT_Takes_SID_fkey" FOREIGN KEY
(
    "SessionID"
)
    REFERENCES public."Session"
(
    "SessionID"
) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    )
    TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."SMTT_Takes"
    OWNER to adminadmin;


--16 Table: public.FS_Has

-- DROP TABLE IF EXISTS public."FS_Has";

CREATE TABLE IF NOT EXISTS public."FS_Has"
(
    "FeedbackID"
    bigint
    NOT
    NULL,
    "SessionID"
    bigint
    NOT
    NULL,
    CONSTRAINT
    "FS_Has_pkey"
    PRIMARY
    KEY
(
    "SessionID"
),
    CONSTRAINT "FS_Has_FID_fkey" FOREIGN KEY
(
    "FeedbackID"
)
    REFERENCES public."Feedback"
(
    "FeedbackID"
) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION,
    CONSTRAINT "FS_Has_SID_fkey" FOREIGN KEY
(
    "SessionID"
)
    REFERENCES public."Session"
(
    "SessionID"
) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    )
    TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."FS_Has"
    OWNER to adminadmin;


--17 Table: public.FM_Gives

-- DROP TABLE IF EXISTS public."FM_Gives";

CREATE TABLE IF NOT EXISTS public."FM_Gives"
(
    "FeedbackID"
    bigint
    NOT
    NULL,
    "MenteeID"
    integer
    NOT
    NULL,
    CONSTRAINT
    "FM_Gives_pkey"
    PRIMARY
    KEY
(
    "FeedbackID",
    "MenteeID"
),
    CONSTRAINT "FM_Gives_FID_fkey" FOREIGN KEY
(
    "FeedbackID"
)
    REFERENCES public."Feedback"
(
    "FeedbackID"
) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION,
    CONSTRAINT "FM_Gives_MID_fkey" FOREIGN KEY
(
    "MenteeID"
)
    REFERENCES public."Mentee"
(
    "MenteeID"
) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    )
    TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."FM_Gives"
    OWNER to adminadmin;


--18 Table: public.SM_Gives

-- DROP TABLE IF EXISTS public."SM_Gives";

CREATE TABLE IF NOT EXISTS public."SM_Gives"
(
    "SessionID"
    bigint
    NOT
    NULL,
    "MentorID"
    integer
    NOT
    NULL,
    CONSTRAINT
    "SM_Gives_pkey"
    PRIMARY
    KEY
(
    "SessionID",
    "MentorID"
),
    CONSTRAINT "SM_Gives_MID_fkey" FOREIGN KEY
(
    "MentorID"
)
    REFERENCES public."Mentor"
(
    "MentorID"
) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION,
    CONSTRAINT "SM_Gives_SID_fkey" FOREIGN KEY
(
    "SessionID"
)
    REFERENCES public."Session"
(
    "SessionID"
) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    )
    TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."SM_Gives"
    OWNER to adminadmin;


