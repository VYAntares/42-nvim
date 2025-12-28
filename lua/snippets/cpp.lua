local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local rep = require("luasnip.extras").rep

return {
	-- Main function
	s("main", {
		t({"int main() {", "\t"}),
		i(1, "// code"),
		t({"", "\treturn (0);", "}"})
	}),

	-- Class OCF
	s("class", {
		t("class "), i(1, "ClassName"), t({" {", "\tprivate:", "\t\t"}),
		i(2, "// attributes"),
		t({"", "", "\tpublic:", "\t\t"}), rep(1), t("();"),
		t({"", "\t\t"}), rep(1), t("(const "), rep(1), t({"& other);", "\t\t"}),
		rep(1), t("& operator=(const "), rep(1), t({"& other);", "\t\t~"}),
		rep(1), t("();"),
		t({"", "};", ""}), i(0)
	}),

	-- Constructor
	s("constr", {
		i(1, "ClassName"), t("::"), rep(1), t({"() {", "\t"}),
		i(2, "// constructor code"),
		t({"", "}", ""}), i(0)
	}),

	-- Copy constructor
	s("copy", {
		i(1, "ClassName"), t("::"), rep(1), t("(const "), rep(1), t({" &other) {", "\t"}),
		i(2, "// copy code"),
		t({"", "}", ""}), i(0)
	}),

	-- Assignment operator
	s("opeq", {
		i(1, "ClassName"), t(" &"), rep(1), t("::operator=(const "), rep(1), t({" &other) {", "\tif (this != &other) {", "\t\t"}),
		i(2, "// assignment code"),
		t({"", "\t}", "\treturn (*this);", "}", ""}), i(0)
	}),

	-- Destructor
	s("destr", {
		i(1, "ClassName"), t("::~"), rep(1), t({"() {", "\t"}),
		i(2, "// destructor code"),
		t({"", "}", ""}), i(0)
	}),

	-- Getter
	s("get", {
		i(1, "int"), t(" get"), i(2, "Attribute"), t({"() const {", "\treturn (_"}),
		i(3, "attribute"), t({");", "}", ""}), i(0)
	}),

	-- Setter
	s("set", {
		t("void set"), i(1, "Attribute"), t("("), i(2, "int"), t(" "), i(3, "value"),
		t({") {", "\t_"}), i(4, "attribute"), t(" = "), rep(3), t({";", "}", ""}), i(0)
	}),

	-- Header guard
	s("guard", {
		t("#ifndef "), i(1, "HEADER"), t({"_HPP", "#define "}), rep(1),
		t({"_HPP", "", "class "}), i(2, "ClassName"), t({" {", "\tprivate:", "\t\t"}),
		i(3, "// attributes"), t({"", "\tpublic:", "\t\t"}), rep(2), t("();"),
		t({"", "\t\t"}), rep(2), t("(const "), rep(2), t({" &other);", "\t\t"}),
		rep(2), t(" &operator=(const "), rep(2), t({" &other);", "\t\t~"}),
		rep(2), t("();"), t({"", "};", "", "#endif", ""}), i(0)
	}),

	-- Try-catch
	s("try", {
		t({"try {", "\t"}), i(1, "// code"),
		t({"", "} catch (std::exception &e) {", "\tstd::cout << e.what() << std::endl;", "}", ""}), i(0)
	}),

	-- Exception class
	s("excep", {
		t("class "), i(1, "ExceptionName"), t({" : public std::exception {", "\tpublic:", "\t\tvirtual const char *what() const throw();", "};", ""}), i(0)
	}),

	-- For loop
	s("for", {
		t("for ("), i(1, "int"), t(" "), i(2, "i"), t(" = "), i(3, "0"), t("; "),
		rep(2), t(" < "), i(4, "n"), t("; "), rep(2), t({"++) {", "\t"}),
		i(5, "// code"), t({"", "}", ""}), i(0)
	}),

	-- If statement
	s("if", {
		t("if ("), i(1, "condition"), t({") {", "\t"}),
		i(2, "// code"), t({"", "}", ""}), i(0)
	}),

	-- While loop
	s("while", {
		t("while ("), i(1, "condition"), t({") {", "\t"}),
		i(2, "// code"), t({"", "}", ""}), i(0)
	}),

	-- std::cout
	s("cout", {
		t("std::cout << "), i(1, "text"), t({" << std::endl;", ""}), i(0)
	}),

	-- std::cerr
	s("cerr", {
		t("std::cerr << "), i(1, "text"), t({" << std::endl;", ""}), i(0)
	}),

	-- Operator << overload
	s("opout", {
		t("std::ostream &operator<<(std::ostream &out, const "), i(1, "ClassName"),
		t({" &obj) {", "\tout << "}), i(2, "obj.getName()"),
		t({";", "\treturn (out);", "}", ""}), i(0)
	}),

	-- Include
	s("inc", {
		t("#include \""), i(1, "header"), t({".hpp\"", ""}), i(0)
	}),

	-- Include iostream
	s("incs", {
		t("#include <iostream>")
	}),

	-- Include string
	s("incstr", {
		t("#include <string>")
	}),

	-- Include exception
	s("incexc", {
		t("#include <exception>")
	}),

	-- Namespace
	s("ns", {
		t("namespace "), i(1, "name"), t({" {", "\t"}),
		i(2, "// content"), t({"", "}", ""}), i(0)
	}),

	-- Makefile 42
	s("make", {
		t("NAME = "), i(1, "program"),
		t({"", "FLAGS = -Wall -Wextra -Werror -std=c++98", "SRC = "}), i(2, "main.cpp"),
		t({"", "OBJ = ${SRC:.cpp=.o}", "", "all: $(NAME)", "", "$(NAME): $(OBJ)", "\tc++ $(FLAGS) $(OBJ) -o $(NAME)", "", "%.o: %.cpp", "\tc++ $(FLAGS) -c $< -o $@", "", "clean:", "\trm -f $(OBJ)", "", "fclean: clean", "\trm -f $(NAME)", "", "re: fclean all", "", ".PHONY: all clean fclean re", ""}), i(0)
	}),

	-- ifndef/define/endif
	s("ifndef", {
		t("#ifndef "), i(1, "HEADER"), t({"_HPP", "#define "}), rep(1),
		t({"_HPP", "", ""}), i(2, "// content"),
		t({"", "", "#endif", ""}), i(0)
	}),

	-- Define
	s("def", {
		t("#define "), i(1, "NAME"), t(" "), i(2, "value"), t({"", ""}), i(0)
	}),

	-- Ifdef block
	s("ifdef", {
		t("#ifdef "), i(1, "MACRO"), t({"", ""}), i(2, "// code"),
		t({"", "#endif", ""}), i(0)
	}),

	-- Ifndef block
	s("ifnd", {
		t("#ifndef "), i(1, "MACRO"), t({"", ""}), i(2, "// code"),
		t({"", "#endif", ""}), i(0)
	}),

	-- Endif comment
	s("endif", {
		t("#endif /* "), i(1, "HEADER"), t({"_HPP */", ""}), i(0)
	}),
}
