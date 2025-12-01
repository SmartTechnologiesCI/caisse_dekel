page 70121 ListePantPlanteurArchive
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;

    SourceTable = Entete_Paiement;
    SourceTableView = where(Archive = const(true));
    CardPageId = ArchiEntetePlanteur;
    Caption = 'Archive Paiement Planteur';
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(NumDocExt; NumDocExt)
                {
                    ApplicationArea = All;
                }

                field(Code_Transporteur; Code_Transporteur)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Nom_Transporteur; Nom_Transporteur)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Palanteur; Palanteur)
                {
                    ApplicationArea = All;
                }
                field(Nom_Planteur; Nom_Planteur)
                {
                    ApplicationArea = All;
                }
                field(Date_Paiement; Date_Paiement)
                {
                    ApplicationArea = All;
                }
                field(Beneficiare; Beneficiare)
                {
                    ApplicationArea = ALL;
                }

            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {

                trigger OnAction()
                begin

                end;
            }
        }
    }
    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        SetFilter(Archive, '=%1', true);
    end;
}