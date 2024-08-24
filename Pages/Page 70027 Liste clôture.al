page 70027 "Liste clôture"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Ouverture de caisse";
    Editable = false;
    CardPageId = 70026;
    SourceTableView = where(status = const(Validated));
    layout
    {
        area(Content)
        {
            repeater("Liste des clôtures")
            {
                field(No; rec.No)
                {
                    ApplicationArea = All;
                    Caption = 'N°';
                }
                field(Date; rec."Date clôture")
                {
                    ApplicationArea = All;
                    Caption = 'Date';
                }
                field(Heure; rec."Heure clôtutre")
                {
                    ApplicationArea = All;
                    Caption = 'Heure';
                }
                field("Code caisse"; rec."Code caisse")
                {
                    ApplicationArea = All;
                    Caption = 'Code caisse';
                }
                field("User id"; rec."User id")
                {
                    ApplicationArea = All;
                    Caption = 'Utilisateur';
                }

                field("Montant clôture"; rec."Montant clôture")
                {
                    ApplicationArea = All;
                    Caption = 'Montant clôture';
                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
    }
    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        SetRange("User id",UserId);
    end;
}