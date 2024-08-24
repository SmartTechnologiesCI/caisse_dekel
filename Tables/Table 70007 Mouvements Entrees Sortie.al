table 70006 "Mouvements Entrees Sorties"
{
    fields
    {
        field(1; "No."; Code[20])
        {
            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    "parametre caisse".Get();
                    NoSeriesMgt.TestManual("parametre caisse"."N° souche Mouvement");
                    "No. Series" := '';
                    /*if xRec."No Point" = '' then
                        "Costing Method" := InvtSetup."Default Costing Method";*/
                end;
            end;
        }
        field(2; "Montant"; Decimal)
        {
            trigger onvalidate()
            var
                myInt: Integer;
            begin
                if (type = type::Sortie) then
                    Montant := -1 * abs(Montant)
                else
                    Montant := Abs(Montant);

            end;
        }
        field(3; "Date"; Date)
        {
            NotBlank = true;
        }
        field(10; "Heure"; Time)
        {
        }
        field(4; "type"; option)
        {
            OptionMembers = "Entree","Sortie";
            OptionCaptionML = ENU = 'Income, Outcome', FRA = 'Entrée, Sortie';
            trigger onvalidate()
            var
                myInt: Integer;
            begin
                if ((type = type::Sortie) OR (Montant < 0)) then
                    Montant := -1 * Montant
                else
                    Montant := Abs(Montant);
            end;
        }
        field(5; "Motif"; Text[100])
        {

        }
        field(6; "Code caisse"; Code[20])
        {
            TableRelation = Caisse."Code caisse" where("User ID" = field("User Id"));
        }

        field(7; "User Id"; Code[50])
        {
            TableRelation = "User Setup"."User ID";
        }
        field(8; "Validated"; Boolean)
        {
        }
        field(9; "No. Series"; Code[20])
        {
            CaptionML = ENU = 'No. Series',
                        FRA = 'N° Séries';
            Editable = false;

            trigger OnLookup();
            begin
                //ASRK1.0 Begin
                /*
                PurchaseSetup.GET;
                Noseries.SETRANGE(Code,PurchaseSetup."Quote Nos.");
                IF PAGE.RUNMODAL(458,Noseries) =ACTION::LookupOK THEN
                 "No. Series" :=Noseries."Series Code";
                //ASRK1.0 END
                */

                /*
                IndentHeaderGRec.RESET;
                WITH IndentHeaderGRec DO BEGIN
                  IndentHeaderGRec := Rec;
                  PurchaseSetup.GET;
                  IF NoSeriesMgt.LookupSeries(PurchaseSetup."Quote Nos.","No. Series") THEN;
                  Rec := IndentHeaderGRec;
                END;
                */

            end;
        }
        field(11; "saved"; Boolean)
        {
        }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }

    var
        EntreeSortie: Record "Mouvements Entrees Sorties";
        "parametre caisse": Record "Parametres caisse";
        NoSeriesMgt: Codeunit NoSeriesManagement;

    trigger OnInsert()
    var
        Caisse: Record Caisse;
    begin
        if "No." = '' then begin
            if ("parametre caisse".Get()) then begin
                "parametre caisse".TestField("N° souche Mouvement");
                NoSeriesMgt.InitSeries("parametre caisse"."N° souche Mouvement", xRec."No. Series", 0D, "No.", "No. Series");
                //"Costing Method" := InvtSetup."Default Costing Method";
                Date := WorkDate;
                Heure := Time;
                "User Id" := UserId;
                Caisse.SetRange("User ID", UserId);
                if (Caisse.FindFirst()) then
                    "Code caisse" := Caisse."Code caisse";
            end;
        end;
    end;


    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;


    procedure AssistEdit_mvt(OldPoint: Record "Mouvements Entrees Sorties"): Boolean;
    begin
        WITH EntreeSortie DO BEGIN
            EntreeSortie := Rec;
            "parametre caisse".Get();
            "parametre caisse".TESTFIELD("N° souche Mouvement");
            IF NoSeriesMgt.SelectSeries("parametre caisse"."N° souche Mouvement", OldPoint."No.", "No.") THEN BEGIN
                "parametre caisse".Get();
                "parametre caisse".TESTFIELD("N° souche Mouvement");
                NoSeriesMgt.SetSeries("No.");
                Rec := EntreeSortie;
                EXIT(TRUE);
            END;
        END;
    end;


}