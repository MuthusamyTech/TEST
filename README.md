 IF @SRID IS NULL
            BEGIN
                RAISERROR ('SRID is null after sp_ServiceRequest execution', 16, 1);
                ROLLBACK TRANSACTION;
                RETURN;
            END
