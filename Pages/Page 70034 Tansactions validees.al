page 70034 "Liste des transactions Valid."
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Transactions;
    Editable = false;
    Caption = 'Liste des transactions archivées';
    SourceTableView = where("validée" = const(true));
    layout
    {
        area(Content)
        {
            repeater("Liste des tranasactions")
            {
                field("N°"; "N°")
                {
                    ApplicationArea = All;
                }
                field(Date; Date)
                {
                    ApplicationArea = All;
                }
                field(Heure; Heure)
                {
                    ApplicationArea = All;
                }
                field(Source; Source)
                {
                    ApplicationArea = All;
                }
                field("N° Document"; "N° Document")
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field("N° Client"; "N° Client")
                {
                    ApplicationArea = All;
                }
                field("Mode de reglement"; "Mode de reglement")
                {
                    ApplicationArea = All;
                }
                field(Montant; Montant)
                {
                    ApplicationArea = All;
                }
                field("Montant recu"; "Montant recu")
                {
                    ApplicationArea = All;
                }
                field("Montant rendu"; "Montant rendu")
                {
                    ApplicationArea = All;
                }
                field("user id"; "user id")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {

    }
    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        //SetRange(Date, WorkDate);

        Rec.SetCurrentKey(Date);
        Rec.SetAscending(Date, false);
    end;
}