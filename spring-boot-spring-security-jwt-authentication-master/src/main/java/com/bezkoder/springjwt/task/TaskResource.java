package com.bezkoder.springjwt.task;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;

@CrossOrigin(origins = "*", maxAge = 3600)
@RestController
@RequestMapping(path = "/api/tasks")
public class TaskResource {

    @Autowired
    private TaskRepository taskRepository;

    @GetMapping
    public List<Task> getTasks(){
        System.out.println("Find all");
        return taskRepository.findAll();
    }

    @PostMapping("/add")
    public Task addTask(@Valid @RequestBody Task taskItem){
        return taskRepository.save(taskItem);
    }

    @PutMapping("/update/{id}")
    public ResponseEntity updateTask(@PathVariable Long id){
        boolean exist = taskRepository.existsById(id);
        if(exist){
            Task task = taskRepository.getById(id);
            boolean done = task.isDone();
            task.setDone(!done);
            taskRepository.save(task);
            return new ResponseEntity<>("Task is updated", HttpStatus.OK);
        }
        return new ResponseEntity<>("Task is not exist", HttpStatus.BAD_REQUEST);
    }

    @DeleteMapping("/delete/{id}")
    public ResponseEntity deleteTask(@PathVariable Long id){
        boolean exist = taskRepository.existsById(id);
        if(exist){
            taskRepository.deleteById(id);
            return new ResponseEntity<>("Task is deleted", HttpStatus.OK);
        }
        return new ResponseEntity<>("Task is not exist", HttpStatus.BAD_REQUEST);
    }
}
