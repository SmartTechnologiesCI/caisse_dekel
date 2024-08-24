page 70082 "ObjectifCommercial subform"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Ligne Ojectif Commercial";
    Caption = 'Details Objectif';




    layout
    {
        area(Content)
        {
            repeater(Details)
            {
                field("Date debut"; rec."Date debut")
                {
                    ShowMandatory = true;
                }
               /*  field("Date fin"; rec."Date fin")
                {

                } */
                field(TypeLigne; rec.TypeLigne)
                {
                    ShowMandatory = true;
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        if rec.TypeLigne = rec.TypeLigne::Article then begin
                            rec.isArticle := true;
                        end else
                            rec.isArticle := false;

                        CurrPage.Update();
                    end;

                }
                field(No; rec."No Article")
                {

                }

                field("Description"; rec."Description")
                {

                }
                field("Qte Poids"; rec."Qte Poids")
                {
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        if Rec."Qte Poids" = 0 then begin
                            Error('Quantite obligatoire');
                        end;
                    end;

                }
                field("Prix article"; rec."Prix article")
                {
                   

                }
                field(Pourcentage; rec.Pourcentage)
                {
                    Editable = rec.isArticle;

                }
                field(Prime; rec.Prime)
                {

                }

            }
        }

    }

    trigger OnNewRecord(belowxRec : Boolean)
    var
        myInt: Integer;
    begin
        Rec."Date debut" := WorkDate();
    end;


    var
        catVisibility: Boolean;
        artVisibility: Boolean;

        visibilityPourcentage: Boolean;


}