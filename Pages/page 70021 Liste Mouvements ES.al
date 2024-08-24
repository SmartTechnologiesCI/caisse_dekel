page 70021 "Liste des mouv. entrees sortie"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Mouvements Entrees Sorties";
    CardPageId = 70020;
    Editable = false;
    layout
    {
        area(Content)
        {
            repeater("Liste des mouvements")
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    trigger OnDrillDown()
                    var
                        mvnt: Record "Mouvements Entrees Sorties";
                    begin
                        mvnt.SetRange("No.", "No.");
                        if (mvnt.FindFirst()) then
                            Page.Run(Page::"Mouvements Entrées et sorties", mvnt);
                    end;
                }
                field(Date; Date)
                {
                    ApplicationArea = All;

                }
                field(Heure; Heure)
                {
                    ApplicationArea = All;

                }
                field(type; type)
                {
                    ApplicationArea = All;

                }
                field(Montant; Montant)
                {
                    ApplicationArea = All;

                }
                field(Motif; Motif)
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    actions
    {
        area(Processing)
        {

        }
    }
    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        SetRange(Date, WorkDate);
    end;

    trigger OnAfterGetRecord()
    var
        caisse: record Caisse;
    begin
        caisse.SetRange("User ID", Rec."User Id");
        if caisse.FindFirst() then begin
            rec."Code caisse" := caisse."Code caisse";
            rec.Modify();
        end;
    end;
}