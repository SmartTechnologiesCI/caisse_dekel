table 70004 "Ouverture de caisse"
{
    //    DrillDownPageId = 70007;
    fields
    {
        field(1; "No"; code[20])
        {

            trigger OnValidate()
            begin
                if "No" <> xRec."No" then begin
                    "Param Caisse".Get();
                    NoSeriesMgt.TestManual("Param Caisse"."N° souche Ouverture");
                    "No. Series" := '';
                    /*if xRec."No Point" = '' then
                        "Costing Method" := InvtSetup."Default Costing Method";*/
                end;
            end;

        }
        field(2; "Date ouverture"; Date)
        {
            NotBlank = true;
        }
        field(3; "Heure ouverture"; Time)
        {
            Editable = false;
        }
        field(4; "Date clôture"; Date)
        {
            NotBlank = true;
        }
        field(5; "Heure clôtutre"; Time)
        {
            Editable = false;
        }
        field(6; "Code caisse"; Code[20])
        {
            Editable = false;
            TableRelation = Caisse."Code caisse" where("User ID" = field("User id"));
            NotBlank = true;
        }
        field(7; "User id"; Code[50])
        {
            Editable = false;
        }
        field(8; "Amount"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum(
                "Billiet ouverture".Total where("N° ouverture" = field("No"))
           );
            FieldClass = FlowField;

        }
        field(12; "Amount2"; Decimal)
        {
            AutoFormatType = 1;
            /* CalcFormula = sum(
                 "Billiet ouverture".Total where("N° ouverture" = field("No"))
            );
             FieldClass = FlowField;*/

        }
        field(9; "Montant clôture"; Decimal)
        {
        }
        field(10; "status"; Option)
        {
            OptionCaptionML = ENU = ' ,Closed,Opened,Validated', FRA = ' ,Clôturé,Ouvert,Validé';
            OptionMembers = " ","Closed","Opened","Validated";
        }
        field(13; "Billetage"; Boolean)
        {
        }

        field(11; "No. Series"; Code[20])
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
    }


    keys
    {
        key(PK; "No")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;
        billet: Record "Billetage";
        billtbyPC: Record "Billiet ouverture";

    trigger OnInsert()
    var
        caisse: Record Caisse;
        OuvertureCaisse: Record "Ouverture de caisse";
    begin
        OuvertureCaisse.SetRange("Date ouverture", WorkDate);
        OuvertureCaisse.SetFilter(status, '=%1|%2', rec.status::Opened, rec.status::Validated);
        OuvertureCaisse.SetFilter("User id", UserId);
        if (OuvertureCaisse.FindFirst()) then
            Error('Il existe déjà une ouverture de caisse non clôturée pour cette journée');

        if "No" = '' then begin
            "Param Caisse".get();
            "Param Caisse".TestField("N° souche Ouverture");
            NoSeriesMgt.InitSeries("Param Caisse"."N° souche Ouverture", xRec."No. Series", 0D, "No", "No. Series");
        end;
        caisse.SetRange("User ID", UserId);
        if (caisse.FindFirst()) then
            "Code caisse" := caisse."Code caisse";
        "Date ouverture" := WorkDate;
        "Heure ouverture" := Time;
        "User id" := UserId;
        status := status::Opened;
        billet.Reset();
        billtbyPC.Reset();
        if billet.FindFirst() then begin
            repeat
                billtbyPC.Reset();
                billtbyPC."Code Caisse" := "Code caisse";
                billtbyPC."Code Billet" := billet."Code Billet";
                billtbyPC."N° ouverture" := "No";
                billtbyPC."Qty." := 0;
                billtbyPC."Total" := 0;
                billtbyPC.Insert();
            until billet.Next = 0;
        end;
        //Amount2 := Amount;
    end;

    trigger OnModify()
    begin
        //Amount2 := Amount;
    end;

    trigger OnDelete()
    begin
        //Amount2 := Amount;
    end;

    trigger OnRename()
    begin
        //Amount2 := Amount;
    end;




    procedure AssistEdit_PointCaisse(OldPoint: Record "Ouverture de caisse"): Boolean;
    begin
        WITH PCaisse DO BEGIN
            PCaisse := Rec;
            "Param Caisse".Get();
            "Param Caisse".TESTFIELD("N° souche Ouverture");
            IF NoSeriesMgt.SelectSeries("Param Caisse"."N° souche Ouverture", OldPoint."No. Series", "No. Series") THEN BEGIN
                "Param Caisse".Get();
                "Param Caisse".TESTFIELD("N° souche Ouverture");
                NoSeriesMgt.SetSeries("No");
                Rec := PCaisse;
                EXIT(TRUE);
            END;
        END;
    end;



    var
        PCaisse: Record "Ouverture de caisse";
        "Param Caisse": Record "Parametres caisse";
        NoSeriesMgt: Codeunit NoSeriesManagement;

}